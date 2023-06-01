import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../api/firebase_auth_api.dart';
import '../models/model_user_info.dart';

class AuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;
  late Stream<User?> uStream;
  User? userObj;

  AuthProvider() {
    authService = FirebaseAuthAPI();
    fetchAuthentication();
  }

  Stream<User?> get userStream => uStream;
  User? get currentUser => userObj;

  void fetchAuthentication() {
    uStream = authService.getUser();
    uStream.listen((user) {
      userObj = user;
    });
    notifyListeners();
    print("in fetch auth");
  }

  Future<String?> signUp(
      String email, String password, UserInfoModel userData) async {
    try {
      String? result = await authService.signUp(email, password, userData);
      if (result != null) {
        notifyListeners();
        return result;
      } else {
        print("check provider");
        return result;
      }
    } catch (error) {
      throw error;
    }
  }

  Future<dynamic> signIn(String email, String password) async {
    try {
      var result = await authService.signIn(email, password);
      notifyListeners();
      return result;
    } catch (error) {
      throw error;
    }
  }

  Future<void> signOut() async {
    try {
      await authService.signOut();
    } catch (error) {
      throw error;
    }
  }
}
