import 'package:flutter/material.dart';
import 'package:pokedex_assessment/core/routes/app_router.dart';
import 'package:pokedex_assessment/viewmodels/auth_viewmodel.dart';
import 'package:pokedex_assessment/views/widgets/button.dart';
import 'package:pokedex_assessment/views/widgets/inputField.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  _register() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please fill in all fields')));
      return;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Passwords do not match')));
      return;
    }
    final authVM = context.read<AuthViewModel>();
    try {
      await authVM.signUpWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 20,
          children: [
            Text('Register', style: Theme.of(context).textTheme.headlineLarge),

            CustomInputField(
              controller: _emailController,
              labelText: 'Email',
              obscureText: false,
            ),
            CustomInputField(
              controller: _passwordController,
              labelText: 'Password',
              obscureText: true,
            ),
            CustomInputField(
              controller: _confirmPasswordController,
              labelText: 'Confirm Password',
              obscureText: true,
            ),
            Row(
              children: [
                Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouter.login);
                  },
                  child: Text('Login'),
                ),
              ],
            ),
            CustomButton(
              onPressed: () async {
                await _register();
                if (context.mounted) {
                  Navigator.pushNamed(context, AppRouter.home);
                }
              },
              label: 'Create Account',
            ),
          ],
        ),
      ),
    );
  }
}
