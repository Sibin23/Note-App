part of 'todo_bloc.dart';

abstract class NoteEvent {}

class GetallNotesEvent extends NoteEvent {}

class NoteAddEvent extends NoteEvent {
  final String title;
  final String content;

  NoteAddEvent({
    required this.title,
    required this.content,
  });
}

