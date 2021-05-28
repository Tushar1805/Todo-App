import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_database/Login/login.dart';
import 'package:sample_database/Login/start.dart';
import 'package:sample_database/Pages/home_page.dart';
import 'package:sample_database/Provider/todos.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = "Todo List";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MaterialApp(
        title: title,
        theme: ThemeData(
            primarySwatch: Colors.yellow,
            scaffoldBackgroundColor: Colors.white),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
