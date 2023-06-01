import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/model_user_info.dart';

class FirebaseAuthAPI {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<User?> getUser() {
    return auth.authStateChanges();
  }

  Future<dynamic> signIn(String email, String password) async {
    UserCredential credential;
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(credential.user!.uid);

      return credential.user!.uid;

      // DocumentSnapshot userInfoSnapshot =
      //     await db.collection('user-info').doc(userId).get();

      // if (userInfoSnapshot.exists) {
      //   Map<String, dynamic> data =
      //       userInfoSnapshot.data() as Map<String, dynamic>;
      //   return UserInfoModel.fromJsonUser(data);
      // }

      //let's print the object returned by signInWithEmailAndPassword
      //you can use this object to get the user's id, email, etc.
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        //possible to return something more useful
        //than just print an error message to improve UI/UX
        return ("Invalid email or password.");
      } else if (e.code == 'invalid-email') {
        return ('Invalid email.');
      } else {
        return (e.code);
      }
    }
  }

  Future<String?> signUp(
      String email, String password, UserInfoModel userData) async {
    UserCredential credential;
    try {
      credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print(userData);

      await db
          .collection("user-info")
          .doc(credential.user!.uid)
          .set(userData.toJsonUser(userData));
      // print(userData.toJsonUser(userData));

      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
