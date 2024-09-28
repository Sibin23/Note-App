import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/core/constants/colors.dart';
import 'package:note_app/core/constants/constants.dart';
import 'package:note_app/core/navigation/navigation_service.dart';
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Title is requred';
                          }
                          return null;
                        },
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Note content is required';
                          }
                          return null;
                        },
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
                  h40,
                  SizedBox(
                    width: size.width,
                    child: Center(
                      child: BlocBuilder<TodoBloc, TodoState>(
                        buildWhen: (previous, currentState) =>
                            currentState is NoteAddEvent,
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
                                if (state is TodoSuccess) {
                                  titleController.clear();
                                  descriptionController.clear();
                                  NavigationService.instance.goBack();
                                  customSnackBar(
                                      context,
                                      "Todo Added Successfully",
                                      greenColor,
                                      blackColor);
                                }
                                if (state is TodoError) {
                                  customSnackBar(
                                      context,
                                      "Failed To Create Todo",
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
                ]),
              ),
            ),
          ),
        ));
  }
}

customSnackBar(
    BuildContext context, String message, Color bg, Color textColor) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: bg,
      content: Text(
        message,
        style: GoogleFonts.roboto(color: textColor),
      )));
}
