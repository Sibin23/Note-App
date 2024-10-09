import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/constants/colors.dart';
import 'package:note_app/core/constants/constants.dart';
import 'package:note_app/core/navigation/navigation_service.dart';
import 'package:note_app/domain/models/todo_model.dart';
import 'package:note_app/presentation/bloc/todo_bloc.dart';
import 'package:note_app/presentation/screens/add_screen/screen_todo_add.dart';
import 'package:note_app/presentation/screens/home/screen_home.dart';

class ScreenTodoEdit extends StatefulWidget {
  const ScreenTodoEdit(
      {super.key,
      required this.isCompleted,
      required this.title,
      required this.description,
      required this.id});
  final bool isCompleted;
  final String title;
  final String description;
  final String id;
  @override
  State<ScreenTodoEdit> createState() => _ScreenTodoEditState();
}

class _ScreenTodoEditState extends State<ScreenTodoEdit> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool? _isChecked;
  @override
  void initState() {
    titleController.text = widget.title;
    descriptionController.text = widget.description;
    _isChecked = widget.isCompleted;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: whitecolor,
        centerTitle: true,
        title: const Text('Edit Task'),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
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
                            disabledBorder: const OutlineInputBorder()),
                      ),
                    ),
                  ),
                  Column(children: [
                    h30,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                            value: _isChecked,
                            onChanged: (value) {
                              setState(() {
                                _isChecked = value!;
                              });
                            }),
                        const Text('Is Task  Done?'),
                      ],
                    )
                  ]),
                  h40,
                  SizedBox(
                    width: size.width,
                    child: Center(
                      child: BlocBuilder<TodoBloc, TodoState>(
                        buildWhen: (previous, currentState) =>
                            currentState is TodoUpdateEvent,
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
                                context.read<TodoBloc>().add(TodoUpdateEvent(
                                    todo: Todo(
                                        id: widget.id,
                                        title: titleController.text.trim(),
                                        description:
                                            descriptionController.text.trim(),
                                        isCompleted: _isChecked)));
                                if (state is TodoSuccess) {
                                  titleController.clear();
                                  descriptionController.clear();
                                  NavigationService.instance
                                      .navigateUntil(const ScreenHome(), () {
                                    context
                                        .read<TodoBloc>()
                                        .add(GetallNotesEvent());
                                  });
                                  customSnackBar(
                                      context,
                                      "Todo Updated Successfully",
                                      greenColor,
                                      blackColor);
                                }
                                if (state is TodoError) {
                                  customSnackBar(
                                      context,
                                      "Failed To Update Todo",
                                      redColor,
                                      blackColor);
                                }
                              }
                            },
                            child: Text(
                                state is TodoLoading ? "Loading" : "Save",
                                style: buttonText),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
