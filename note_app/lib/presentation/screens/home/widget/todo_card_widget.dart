import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/core/constants/colors.dart';
import 'package:note_app/core/constants/constants.dart';
import 'package:note_app/domain/models/todo_model.dart';

class TodoCardWidget extends StatelessWidget {
  const TodoCardWidget({
    super.key,
    required this.size, required this.todoList, required this.voidCallback,
  });
final List<Todo> todoList;
  final Size size;
  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              voidCallback();
            },
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
                            todoList[index].title,
                            style: titleTextStyle,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(8),
                                color: todoList[index]
                                            .isCompleted ==
                                        false
                                    ? pendingBg
                                    : completedBg),
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(8.0),
                              child: Text(
                                todoList[index]
                                            .isCompleted ==
                                        false
                                    ? 'PENDING'
                                    : 'COMPLETED',
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: todoList[index]
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
                            todoList[index].description,
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
        itemCount: todoList.length);
  }
}
