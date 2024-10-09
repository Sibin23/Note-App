import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:note_app/domain/models/todo_model.dart';
import 'package:note_app/domain/services/todo_services.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<NoteEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<NoteEvent>((event, emit) async {
      if (event is GetallNotesEvent) {
        emit(TodoLoading());
        try {
          final response = await ApiServices.fetchTodos();
          if (kDebugMode) {
            print("Response is $response");
          }

          emit(TodoSuccess(response));
        } catch (e) {
          emit(TodoError(message: e.toString()));
        }
      } else if (event is NoteAddEvent) {
        try {
          await ApiServices.createTodo(Todo(
              title: event.title,
              description: event.description,
              isCompleted: event.isCompleted));
          final response = await ApiServices.fetchTodos();
          emit(TodoSuccess(response));
        } catch (e) {
          emit(TodoError(message: e.toString()));
        }
      } else if (event is TodoUpdateEvent) {
        emit(TodoLoading());
        try {
          await ApiServices.updateTodo(event.todo);
          final response = await ApiServices.fetchTodos();
          emit(TodoSuccess(response));
        } catch (e) {
          emit(TodoError(message: e.toString()));
        }
      } else if (event is TodoDeleteEvent) {
        emit(TodoLoading());
        try {
          await ApiServices.deleteTodo(event.id);
          final response = await ApiServices.fetchTodos();
          emit(TodoSuccess(response));
        } catch (e) {
          emit(TodoError(message: e.toString()));
        }
      }
    });
  }
}
