import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/core/constants/colors.dart';
import 'package:note_app/core/constants/constants.dart';
import 'package:note_app/core/navigation/navigation_service.dart';
import 'package:note_app/domain/models/todo_model.dart';
import 'package:note_app/presentation/bloc/todo_bloc.dart';
import 'package:note_app/presentation/screens/edit_screen/screen_todo_edit.dart';
import 'package:note_app/presentation/screens/home/screen_home.dart';

class ScreenTodo extends StatelessWidget {
  const ScreenTodo({
    super.key,
    required this.todo,
  });
  final Todo todo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Todo Screen'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                iconSize: 30,
                splashColor: whitecolor,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            backgroundColor: whitecolor,
                            surfaceTintColor: whitecolor,
                            iconColor: redColor,
                            icon: const Icon(
                              Icons.warning_amber_rounded,
                              size: 100,
                            ),
                            title: const Text('Are You Sure?'),
                            content: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('You Won\'t be able to revert.'),
                              ],
                            ),
                            actionsAlignment: MainAxisAlignment.spaceEvenly,
                            actions: [
                              TextButton(
                                  style: TextButton.styleFrom(
                                      elevation: 5,
                                      backgroundColor: blueColor,
                                      foregroundColor: whitecolor,
                                      textStyle:
                                          GoogleFonts.roboto(fontSize: 20),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  onPressed: () {
                                    NavigationService.instance.goBack();
                                  },
                                  child: const Text('Cancel')),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      elevation: 5,
                                      backgroundColor: redColor,
                                      foregroundColor: whitecolor,
                                      textStyle:
                                          GoogleFonts.roboto(fontSize: 20),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  onPressed: () {
                                    context
                                        .read<TodoBloc>()
                                        .add(TodoDeleteEvent(id: todo.id!));
                                    NavigationService.instance
                                        .navigateUntil(const ScreenHome());
                                    customSnackBar(
                                        context,
                                        'Deleted',
                                        "Todo Deleted Successfully!",
                                        AnimatedSnackBarType.success);
                                  },
                                  child: const Text('Delete')),
                            ],
                          ));
                },
                icon: const Icon(
                  Icons.delete,
                  color: redColor,
                )),
          )
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            h40,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  todo.title,
                  style: titleTextStyle,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color:
                          todo.isCompleted == false ? pendingBg : completedBg),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      todo.isCompleted == false ? 'PENDING' : 'COMPLETED',
                      style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: todo.isCompleted == false
                              ? pendingTextColor
                              : greenColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
            h30,
            Text(
              todo.description,
              style: GoogleFonts.roboto(fontSize: 18),
            )
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
          backgroundColor: appTheme,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.edit,
          ),
          onPressed: () {
            NavigationService.instance.navigate(ScreenTodoEdit(
              todo: todo,
            ));
          }),
    );
  }
}
