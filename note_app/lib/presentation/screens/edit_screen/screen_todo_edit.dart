import 'package:flutter/material.dart';
import 'package:note_app/core/constants/colors.dart';
import 'package:note_app/core/constants/constants.dart';

class ScreenTodoEdit extends StatefulWidget {
  const ScreenTodoEdit(
      {super.key,
      required this.isCompleted,
      required this.title,
      required this.description});
  final bool isCompleted;
  final String title;
  final String description;

  @override
  State<ScreenTodoEdit> createState() => _ScreenTodoEditState();
}

class _ScreenTodoEditState extends State<ScreenTodoEdit> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    titleController.text = widget.title;
    descriptionController.text = widget.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    bool _isCompleted = widget.isCompleted;
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
                      onPressed: () {},
                      child: Text(
                        'Save',
                        style: buttonText,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
