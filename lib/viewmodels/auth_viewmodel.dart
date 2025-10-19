import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' show ChangeNotifier;

class AuthViewModel extends ChangeNotifier {
  AuthViewModel() {
    _auth.authStateChanges().listen((user) {
      notifyListeners();
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _loading = false;

  User? get currentUser => _auth.currentUser;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    loading = true;
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      loading = false;
      return user.user;
    } catch (e) {
      loading = false;
      throw Exception(e);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<User?> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    loading = true;
    try {
      final user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      loading = false;
      return user.user;
    } catch (e) {
      loading = false;
      throw Exception(e);
    }
  }
}
