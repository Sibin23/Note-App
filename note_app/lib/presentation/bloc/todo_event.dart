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
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  TodoUpdateEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  });
}

class TodoDeleteEvent extends NoteEvent {
  final String id;

  TodoDeleteEvent({required this.id});
}
