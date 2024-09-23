import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/core/constants/colors.dart';
import 'package:note_app/core/constants/constants.dart';
import 'package:note_app/core/navigation/navigation_service.dart';
import 'package:note_app/presentation/bloc/note_bloc.dart';
import 'package:note_app/presentation/screens/add_screen/screen_todo_add.dart';
import 'package:note_app/presentation/screens/edit_screen/screen_todo_edit.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    context.read<NoteBloc>().add(GetallNotesEvent());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Todo List"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => NavigationService.instance
                      .navigate(const ScreenTodoEdit()),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Title',
                                  style: titleTextStyle,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: completedBg),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'PENDING',
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            h10,
                            SizedBox(
                                width: size.width,
                                child: Text(
                                  'Jackfklsjfsdfsdfsadfsdfdsfdassdfsadfsdfasdfasfsdfdfasfsdafljfj;lfjaja;sljsdfsdfasfdsfsadfasdfsdfasdfsdafasdfasdfasdfdfasdffasdfsadfasdfasdfsdfasdfsadfsdadsfasfsadfds',
                                  style: GoogleFonts.roboto(fontSize: 15),
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
              itemCount: 10),
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
