import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sample_database/Pages/edit_todo_page.dart';
import 'package:sample_database/Provider/todos.dart';
import 'package:sample_database/model/todo.dart';

import '../utils.dart';

String uid = FirebaseAuth.instance.currentUser.uid;

class TodoWidget extends StatelessWidget {
  final Todo todo;

  const TodoWidget({
    @required this.todo,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
          child: buildTodo(context),
          actionPane: SlidableDrawerActionPane(),
          key: Key(todo.id),
          actions: [
            IconSlideAction(
              color: Colors.green,
              icon: Icons.edit,
              caption: "Edit",
              onTap: () => editTodo(context, todo),
            )
          ],
          secondaryActions: [
            IconSlideAction(
              color: Colors.red,
              caption: 'Delete',
              onTap: () => deleteTodo(context, todo),
              icon: Icons.delete,
            )
          ],
        ),
      );

  Widget buildTodo(BuildContext context) {
    return GestureDetector(
      onTap: () => editTodo(context, todo),
      child: Container(
        color: Colors.red.shade50,
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Checkbox(
              activeColor: Colors.green,
              checkColor: Colors.white,
              value: todo.isDone,
              onChanged: (_) {
                final provider =
                    Provider.of<TodoProvider>(context, listen: false);
                final isDone = provider.toggleTodoStatus(todo);
                Utils.showSnackBar(
                  context,
                  isDone ? 'Task Completed' : 'Task Marked Incompleete',
                );
              },
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                if (todo.description.isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Text(
                      todo.description,
                      style: TextStyle(fontSize: 17, height: 1.5),
                    ),
                  )
              ],
            ))
          ],
        ),
      ),
    );
  }

  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodoProvider>(context, listen: false);
    provider.removeTodo(todo, uid);

    Utils.showSnackBar(context, "Deleted the task");
  }

  void editTodo(BuildContext context, Todo todo) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditTodoPage(
            todo: todo,
          ),
        ),
      );
}
