import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/core/constants/colors.dart';
import 'package:note_app/core/navigation/navigation_service.dart';
import 'package:note_app/presentation/bloc/todo_bloc.dart';
import 'package:note_app/presentation/screens/add_screen/screen_todo_add.dart';
import 'package:note_app/presentation/screens/home/widget/todo_card_widget.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    context.read<TodoBloc>().add(GetallNotesEvent());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appTheme,
        centerTitle: true,
        title: const Text("Todo List"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<TodoBloc>().add(GetallNotesEvent());
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
              if (state is TodoSuccess) {
                return state.todos.isEmpty
                    ? Center(
                        child: Lottie.asset(
                            'assets/Animation - 1715440391123.json'),
                      )
                    : TodoCardWidget(
                        size: size,
                        todoList: state.todos,
                      );
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
          child: const Icon(Icons.add)),
    );
  }
}
