import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_database/Login/database.dart';
import 'package:sample_database/Widget/todo_widget.dart';

class ProfileWidget extends StatelessWidget {
  final String uid;
  ProfileWidget({this.uid});

  @override
  Widget build(BuildContext context) {
//     CollectionReference users = FirebaseFirestore.instance.collection('users');

//     return FutureBuilder<DocumentSnapshot>(
//       future: users.doc(uid).get(),
//       builder:
//           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text("Something went wrong");
//         }

//         if (snapshot.connectionState == ConnectionState.done) {
//           Map<String, dynamic> data = snapshot.data.data();
//           return Container(
//             // child: Column(
//             //   children: <Widget>[
//             //      Text(
//             //        "Full Name: ${data['name']}",
//             //        style: TextStyle(fontSize: 25),
//             //      ),
//             //      Text(
//             //        "Email : ${data['email']}",
//             //        style: TextStyle(fontSize: 20),
//             //      ),
// //                Stack(
// //                  alignment: Alignment.center,
// //                  children: <Widget>[
// //                    Image(
// //                      height: MediaQuery.of(context).size.height / 3,
// //                      fit: BoxFit.cover,
// //                      image: AssetImage("images/todoListBanner.jpeg"),
// //                    ),
// //                    Positioned(
// //                      child: CircleAvatar(
// //                        radius: 80,
// //                        backgroundColor: Colors.white,
// //                        backgroundImage: AssetImage("images/profile.jpeg"),
// //                      ),
// //                    )
// //                  ],
// //                ),
//               ],
//             ),
//           );
//         }
//         return Text("loading");
//       },
//     );
    return Container();
  }
}
