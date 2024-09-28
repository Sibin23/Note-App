import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/constants/colors.dart';
import 'package:note_app/core/constants/constants.dart';
import 'package:note_app/presentation/bloc/todo_bloc.dart';

class ScreenTodoAdd extends StatefulWidget {
  const ScreenTodoAdd({
    super.key,
  });

  @override
  State<ScreenTodoAdd> createState() => _ScreenTodoAddState();
}

class _ScreenTodoAddState extends State<ScreenTodoAdd> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: whitecolor,
          centerTitle: true,
          title: const Text('Add Note'),
        ),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: ListView(children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    width: size.width,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                      color: appTheme,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                            hintStyle: hintTextStyle,
                            hintText: 'Title..,',
                            border: InputBorder.none,
                            disabledBorder: const OutlineInputBorder()),
                      ),
                    ),
                  ),
                  h30,
                  Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                      color: appTheme,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: descriptionController,
                        maxLines: 6,
                        decoration: InputDecoration(
                            hintStyle: hintTextStyle,
                            hintText: 'Write a note..',
                            border: InputBorder.none,
                            disabledBorder: OutlineInputBorder()),
                      ),
                    ),
                  ),
                  h40,
                  SizedBox(
                    width: size.width,
                    child: Center(
                      child: BlocConsumer<TodoBloc, TodoState>(
                        builder: (context, state) {
                          return MaterialButton(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            splashColor: whitecolor,
                            minWidth: size.width * 2 / 4,
                            height: 50,
                            color: Colors.grey.shade200,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<TodoBloc>().add(NoteAddEvent(
                                    title: titleController.text.trim(),
                                    description:
                                        descriptionController.text.trim(),
                                    isCompleted: false));
                              }
                            },
                            child:
                                Text(state is TodoLoading ? 'Loading' : "Save"),
                          );
                        },
                        listener: (context, state) {
                          if (state is TodoSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Todo added successfully!'),
                              ),
                            );
                            titleController.clear();
                            descriptionController.clear();
                          } else if (state is TodoError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Error adding todo: ${state.message}'),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ));
  }
}
