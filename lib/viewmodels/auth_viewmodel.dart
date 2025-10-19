import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' show ChangeNotifier;

class AuthViewModel extends ChangeNotifier {
  AuthViewModel() {
    _auth.authStateChanges().listen((user) {
      notifyListeners();
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user.user;
    } catch (e) {
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
    try {
      final user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user.user;
    } catch (e) {
      throw Exception(e);
    }
  }
}
