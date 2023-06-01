import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserInfoAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getCurrentUserData() {
    return db.collection("user-info").snapshots();
  }
}
