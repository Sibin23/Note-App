import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:note_app/domain/models/todo_model.dart';

class ApiServices {
  static const String endpoint = "https://api.nstack.in/v1/todos";

  static Future<List<Todo>> fetchTodos() async {
    try {
      final response = await http.get(Uri.parse(endpoint));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print("RESponse data is $responseData");
        final List<dynamic> items = responseData['items'];
        print("Items is $items");
        return items.map((json) => Todo.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch todos');
      }
    } catch (e) {
      print('Error fetching todos: $e');
      throw Exception('Failed to fetch todos');
    }
  }

  static Future<void> createTodo(Todo todo) async {
    try {
      final response = await http.post(
        Uri.parse(endpoint),
        body: {
          'title': todo.title,
          'description': todo.description,
          'is_completed': 'false', 
        },
      );

      if (response.statusCode == 201) {
        print("Todo Created");
      } else {
        print('Failed to create todo ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating todo: $e');
      throw Exception('Failed to create todo');
    }
  }
}
