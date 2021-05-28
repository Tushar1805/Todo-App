import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sample_database/model/todo.dart';
import 'package:flutter/material.dart';
import 'package:sample_database/utils.dart';

class FirebaseApi {
  static Future<String> createTodo(Todo todo, String uid) async {
    final docTodo = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('todo')
        .doc(todo.id);

    todo.id = docTodo.id;
    await docTodo.set(todo.toJson());

    return docTodo.id;
  }

  static Stream<List<Todo>> readTodos(String uid) => FirebaseFirestore.instance
      .collection("users/" + uid + "/todo")
      .orderBy(TodoField.createdTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(Todo.fromJson));

  static Future updateTodo(Todo todo, String uid) async {
    final docTodo = FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection('todo')
        .doc(todo.id);

    await docTodo.update(todo.toJson());
  }

  static Future deleteTodo(Todo todo, String uid) async {
    final docTodo = FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection('todo')
        .doc(todo.id);

    await docTodo.delete();
  }

  static Future<void> userName(String displayName) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.add({'displaName': displayName});
    return;
  }
}
