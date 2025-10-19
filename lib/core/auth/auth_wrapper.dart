import 'package:flutter/material.dart';
import 'package:pokedex_assessment/viewmodels/auth_viewmodel.dart';
import 'package:pokedex_assessment/views/auth/login_screen.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  final Widget child;
  const AuthWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final authVM = context.watch<AuthViewModel>();
    if (authVM.currentUser == null) {
      return LoginScreen();
    }
    return child;
  }
}
