import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_database/Provider/todos.dart';
import 'package:sample_database/Widget/todo_form_widget.dart';
import 'package:sample_database/model/todo.dart';

class EditTodoPage extends StatefulWidget {
  final Todo todo;

  const EditTodoPage({Key key, @required this.todo}) : super(key: key);

  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final _formKey = GlobalKey<FormState>();

  String title;
  String description;
  String uid;

  @override
  void initState() {
    super.initState();

    title = widget.todo.title;
    description = widget.todo.description;
    uid = FirebaseAuth.instance.currentUser.uid;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Edit Todo"),
          actions: [
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  final provider =
                      Provider.of<TodoProvider>(context, listen: false);
                  provider.removeTodo(widget.todo, uid);

                  Navigator.of(context).pop();
                }),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: TodoFormWidget(
              title: title,
              description: description,
              onChangedTitle: (title) => setState(() => this.title = title),
              onChangedDescription: (description) =>
                  setState(() => this.description = description),
              onSavedTodo: saveTodo,
            ),
          ),
        ),
      );

  void saveTodo() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<TodoProvider>(context, listen: false);
      provider.updateTodo(widget.todo, title, description, uid);

      Navigator.of(context).pop();
    }
  }
}
