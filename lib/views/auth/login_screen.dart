import 'package:flutter/material.dart';
import 'package:pokedex_assessment/core/routes/app_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            Text('Login', style: Theme.of(context).textTheme.headlineLarge),
            TextField(decoration: InputDecoration(labelText: 'Email')),
            TextField(decoration: InputDecoration(labelText: 'Password')),
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
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.home);
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
