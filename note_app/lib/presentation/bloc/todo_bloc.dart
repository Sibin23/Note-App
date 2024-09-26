import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:note_app/domain/models/todo_model.dart';
import 'package:note_app/domain/services/todo_services.dart';
part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<TodoEvent>((event, emit) async {
      if (event == TodoEvent.fetchTodos) {
        emit(TodoLoading());
        try {
          final response = await ApiServices.fetchTodos();
          print("Response is ${response}");
          final List<Todo> todos = response;
          emit(TodoLoaded(todos));
        } catch (e) {
          emit(TodoError(message: e.toString()));
        }
      } else if (event == TodoEvent.createTodo) {
        // Handle creating a new Todo
        emit(TodoLoading());
        try {
          await ApiServices.createTodo(Todo(
            title: 'New Todo', // Provide a default title (optional)
            description: '', // Allow empty description for now
            isCompleted: false,
          ));

          // Optional: Update loaded todos after creation
          // You might need to fetch todos again or update the state locally

          // emit(const TodoLoaded([])); // This might not be necessary
        } catch (e) {
          emit(TodoError(message: e.toString()));
        }
      }
    });
  }
}
