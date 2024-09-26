import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/core/constants/colors.dart';
import 'package:note_app/core/constants/constants.dart';
import 'package:note_app/core/navigation/navigation_service.dart';
import 'package:note_app/presentation/bloc/todo_bloc.dart';
import 'package:note_app/presentation/screens/add_screen/screen_todo_add.dart';
import 'package:note_app/presentation/screens/edit_screen/screen_todo_edit.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    context.read<TodoBloc>().add(TodoEvent.fetchTodos);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Todo List"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<TodoBloc>().add(TodoEvent.fetchTodos);
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
              if (state is TodoLoading) {
                return Center(child: Lottie.asset("assets/loading.json"));
              }
              if (state is TodoError) {
                return Column(
                  children: [
                    Lottie.asset("assets/Animation - 1715440862032.json"),
                  ],
                );
              }
              if (state is TodoLoaded) {
                return state.toString().isEmpty
                    ? Center(
                        child: Lottie.asset(
                            'assets/Animation - 1715440391123.json'),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          final todoList = state.props[index];
                          print(todoList);
                          return InkWell(
                            onTap: () => NavigationService.instance
                                .navigate(ScreenTodoEdit(
                              title: state.todos[index].title,
                              description: state.todos[index].description,
                              isCompleted: state.todos[index].isCompleted!,
                            )),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: whitecolor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                      )
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            state.todos[index].title,
                                            style: titleTextStyle,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: state.todos[index]
                                                            .isCompleted ==
                                                        false
                                                    ? pendingBg
                                                    : completedBg),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                state.todos[index]
                                                            .isCompleted ==
                                                        false
                                                    ? 'PENDING'
                                                    : 'COMPLETED',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 16,
                                                    color: state.todos[index]
                                                                .isCompleted ==
                                                            false
                                                        ? pendingTextColor
                                                        : greenColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      h10,
                                      SizedBox(
                                          width: size.width,
                                          child: Text(
                                            state.todos[index].title,
                                            style: GoogleFonts.roboto(
                                                fontSize: 15),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: state.todoCount);
              }
              return const SizedBox();
            }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: appTheme,
          shape: const CircleBorder(),
          onPressed: () =>
              NavigationService.instance.navigate(const ScreenTodoAdd()),
          child: Icon(Icons.add)),
    );
  }
}
