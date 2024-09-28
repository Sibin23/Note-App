import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  String? id;
  String title;
  String description;
  bool? isCompleted;

  Todo({
    this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  });
  @override
  List<Object?> get props => [id, title, description, isCompleted];

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['is_completed'],
    );
  }
  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) =>
      Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        isCompleted: isCompleted ?? this.isCompleted,
      );
}
