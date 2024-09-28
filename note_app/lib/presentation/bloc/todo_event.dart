part of 'todo_bloc.dart';

abstract class NoteEvent {}

class GetallNotesEvent extends NoteEvent {}

class NoteAddEvent extends NoteEvent {
  final String title;
  final String description;
  final bool isCompleted;
  NoteAddEvent({
    required this.title,
    required this.description,
    required this.isCompleted,
  });
}

class TodoUpdateEvent extends NoteEvent {
  final Todo todo;
  TodoUpdateEvent({
    required this.todo,
  });
}

class TodoDeleteEvent extends NoteEvent {
  final Todo todo;

  TodoDeleteEvent({required this.todo});
}
