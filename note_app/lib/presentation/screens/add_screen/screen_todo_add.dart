import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:note_app/core/constants/colors.dart';
import 'package:note_app/core/constants/constants.dart';
import 'package:note_app/core/constants/strings.dart';
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
                      child: MaterialButton(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        splashColor: whitecolor,
                        minWidth: size.width * 2 / 4,
                        height: 50,
                        color: Colors.grey.shade200,
                        onPressed: () async {
                          validate(context);
                        },
                        child: const Text("Save"),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ));
  }

  void validate(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        // context.read<NoteBloc>().add(NoteAddEvent(
        //     title: titleController.text, content: descriptionController.text));
        // NavigationService.instance.goBack();
        final body = {
          'title': titleController.text.trim(),
          'description': descriptionController.text.trim(),
          'is_completed': 'false',
        };
        final response = await http.post(Uri.parse(baseUrl),
            body: jsonEncode(body),
            headers: {'Content-Type': ' application/json'});
        if (response.statusCode == 201) {
          print("Todo Created");
          showSuccessSnackBar('Added Successfully', greenColor);
        } else {
          print('Failed to create todo ${response.statusCode}');
          showSuccessSnackBar('Failed to create Todo', Colors.red);
        }
      } catch (e) {
        print(e.toString());
      }
      formKey.currentState!.reset();
    }
  }

  showSuccessSnackBar(String message, Color color) {
    final snackBar = SnackBar(backgroundColor: color, content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
