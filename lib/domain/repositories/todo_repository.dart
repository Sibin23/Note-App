import 'package:note_app/domain/models/todo_model.dart';

abstract class TodoRepository {
  //get list of Todo's
Future<List<Todo>> getTodos();
  // add new Todo
Future<void> addTodo(Todo newTodo);
  //update an Existing Todo
Future<void> updateTodo(Todo updatedTodo);
  // Delete a Todo
  Future<void> deleteTodo(Todo deleteTodo);
}