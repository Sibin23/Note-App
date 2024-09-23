import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/core/constants/colors.dart';
import 'package:note_app/core/constants/constants.dart';
import 'package:note_app/presentation/bloc/note_bloc.dart';

class ScreenTodoAdd extends StatefulWidget {
  const ScreenTodoAdd({
    super.key,
    this.add = true,
    this.description,
    this.title,
    this.id,
  });
  final bool add;
  final String? title;
  final String? description;
  final int? id;

  @override
  State<ScreenTodoAdd> createState() => _ScreenTodoAddState();
}

class _ScreenTodoAddState extends State<ScreenTodoAdd> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  @override
  void initState() {
    if (widget.title != null && widget.description != null) {
      titleController.text = widget.title!;
      subjectController.text = widget.description!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<NoteBloc, NoteState>(listener: (context, state) {
      if (state is ErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red.shade300,
            duration: const Duration(seconds: 1),
            content: Text(state.errorMessage),
          ),
        );
      }
      if (state is ScuccessState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green.shade300,
            duration: const Duration(seconds: 1),
            content: state.add
                ? const Text("Note Added")
                : const Text("Note Edited"),
          ),
        );
        state.add
            ? Navigator.pop(context)
            : Navigator.of(context).popUntil((route) => route.isFirst);
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          surfaceTintColor: whitecolor,
          centerTitle: true,
          title: Text(widget.add ? "Add Note" : "Edit Note"),
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
                        controller: subjectController,
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
                          widget.add
                              ? context.read<NoteBloc>().add(
                                    NoteAddEvent(
                                      title: titleController.text,
                                      content: subjectController.text,
                                      isCompleted: false,
                                    ),
                                  )
                              : context.read<NoteBloc>().add(
                                    NoteEditEvent(
                                      title: titleController.text,
                                      content: subjectController.text,
                                      id: widget.id!,
                                    ),
                                  );
                        },
                        child: BlocBuilder<NoteBloc, NoteState>(
                          builder: (context, state) {
                            if (state is LoadingState) {
                              return Lottie.asset(
                                "assets/butttonloading.json",
                                width: 40,
                              );
                            }
                            return const Text("Save");
                          },
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
    });
  }
}
