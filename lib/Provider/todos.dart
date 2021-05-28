import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sample_database/api/firebase_api.dart';
import 'package:sample_database/model/todo.dart';

class TodoProvider extends ChangeNotifier {
  String uid = FirebaseAuth.instance.currentUser.uid;

  // ignore: unused_field
  List<Todo> _todos = [];

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();

  List<Todo> get todosCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();

  void setTodos(List<Todo> todos) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _todos = todos;
        notifyListeners();
      });

  void addTodo(Todo todo, String uids) => FirebaseApi.createTodo(todo, uids);

  void removeTodo(Todo todo, String uid) => FirebaseApi.deleteTodo(todo, uid);

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    FirebaseApi.updateTodo(todo, uid);

    return todo.isDone;
  }

  void updateTodo(Todo todo, String title, String description, String uid) {
    todo.title = title;
    todo.description = description;

    FirebaseApi.updateTodo(todo, uid);
  }
}
