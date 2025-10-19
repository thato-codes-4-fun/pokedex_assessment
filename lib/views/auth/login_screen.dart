import 'package:flutter/material.dart';
import 'package:pokedex_assessment/core/routes/app_router.dart';
import 'package:pokedex_assessment/viewmodels/auth_viewmodel.dart';
import 'package:pokedex_assessment/views/widgets/button.dart';
import 'package:pokedex_assessment/views/widgets/inputField.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please fill in all fields')));
      return;
    }
    final authVM = context.read<AuthViewModel>();
    try {
      await authVM.signInWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 20,
          children: [
            // Image.asset(
            //   'assets/images/logo.png',
            //   width: 100,
            //   height: 100,
            //   fit: BoxFit.cover,
            // ),
            Text(
              "PokeDex Assessment",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text('Login', style: Theme.of(context).textTheme.headlineMedium),
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
            Row(
              children: [
                Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouter.register);
                  },
                  child: Text('Register'),
                ),
              ],
            ),
            CustomButton(
              onPressed: () async {
                await _login();
                if (context.mounted) {
                  Navigator.pushNamed(context, AppRouter.home);
                }
              },
              label: 'Login',
            ),
          ],
        ),
      ),
    );
  }
}
