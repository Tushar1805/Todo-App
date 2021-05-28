import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_database/Login/database.dart';
import 'package:sample_database/Login/register.dart';
import 'package:sample_database/Login/start.dart';
import 'package:sample_database/Provider/todos.dart';
import 'package:sample_database/Widget/completed_list_widget.dart';
import 'package:sample_database/Widget/profile_widget.dart';
import 'package:sample_database/Widget/todo_list_widget.dart';
import 'package:sample_database/Widget/todo_widget.dart';
import 'package:sample_database/api/firebase_api.dart';
import 'package:sample_database/main.dart';
import 'package:sample_database/Widget/add_todo_dialog.dart';
import 'package:sample_database/model/todo.dart';
import 'package:sample_database/Login/register.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Register reg = new Register();
  bool isLoggedIn = false;
  User user = FirebaseAuth.instance.currentUser;
  String uid, name;
  //String name = FirebaseAuth.instance.currentUser.displayName;

  int selectedIndex = 0;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Start()));
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isLoggedIn = true;
        this.uid = firebaseUser.uid.toString();
        this.name = firebaseUser.email;
      });
    }
  }

  signOut() async {
    _auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are You Sure?"),
            content: Text("You are going to exit the application..."),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  "NO",
                  style: TextStyle(color: Colors.green),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  "YES",
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    DatabaseService ds = DatabaseService(uid: uid);
    if (!isLoggedIn) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      final tabs = [
        TodoListWidget(),
        CompletedListWidget(),
        ProfileWidget(
          uid: uid,
        ),
      ];
      return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          appBar: AppBar(
            // title: Text("Hello, ${user.displayName}"),
            title: Text(
              "Hello, ${ds.getUserName().then((value) => value[1])}",
              style: TextStyle(fontSize: 10),
            ),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: signOut,
                    tooltip: "Logout",
                  ),
                ],
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.black,
            currentIndex: selectedIndex,
            onTap: (index) => setState(() {
              selectedIndex = index;
            }),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.fact_check_outlined), label: 'Todos'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.done,
                    size: 28,
                  ),
                  label: 'Completed'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_circle,
                    size: 28,
                  ),
                  label: 'Profile'),
            ],
          ),
          body: StreamBuilder<List<Todo>>(
            stream: FirebaseApi.readTodos(uid),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  } else {
                    final todos = snapshot.data;

                    final provider = Provider.of<TodoProvider>(context);
                    provider.setTodos(todos);

                    return tabs[selectedIndex];
                  }
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.black,
            onPressed: () => showDialog(
                context: context,
                builder: (context) => AddTodoDialogWidget(),
                barrierDismissible: false),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }
}
