import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:note_app/domain/models/todo_model.dart';
import 'package:note_app/presentation/bloc/todo_bloc.dart';

class ApiServices {
  static const String endpoint = "https://api.nstack.in/v1/todos";

  static Future<List<Todo>> fetchTodos() async {
    try {
      final response = await http.get(Uri.parse(endpoint));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        final List<dynamic> items = responseData['items'];

        return items.map((json) => Todo.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch todos');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching todos: $e');
      }
      throw Exception('Failed to fetch todos');
    }
  }

  static Future<void> createTodo(Todo todo) async {
    final body = {
      'title': todo.title,
      'description': todo.description,
      'is_completed': todo.isCompleted,
    };
    try {
      final response = await http.post(Uri.parse(endpoint),
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});

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
