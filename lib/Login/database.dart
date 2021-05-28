import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final user = FirebaseFirestore.instance.collection('users/');

  Future updateUserData(String name, String email, String password) async {
    return user
        .doc(uid)
        .set({'name': name, 'email': email, 'password': password});
  }

  Stream<QuerySnapshot> get users {
    return user.snapshots();
  }

  Future getCurrentUser() async {
    final users = FirebaseFirestore.instance.collection('users/' + uid);
    try {
      DocumentSnapshot qs = await users.doc(uid).get();
      String name = qs.get("name");
      return [name];
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> getUserName() async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('UserNames');

    final String uid = FirebaseAuth.instance.currentUser.uid;

    final result = await users.doc(uid).get();

    return result.data()['displayName'];
  }
}
