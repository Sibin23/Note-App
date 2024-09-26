part of 'todo_bloc.dart';

enum TodoEvent { fetchTodos, createTodo }

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object?> get props => [];

  int get todoCount => props.length;
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos; 


  const TodoLoaded(this.todos);

  @override
  List<Object?> get props => [todos]; 
 // Return the list of Todo objects
}

class TodoError extends TodoState {
  final String message;

  const TodoError({required this.message});
}