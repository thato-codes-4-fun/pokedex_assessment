import 'package:flutter/material.dart';
import 'package:pokedex_assessment/core/routes/app_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
            Text('Register', style: Theme.of(context).textTheme.headlineLarge),
            TextField(decoration: InputDecoration(labelText: 'Username')),
            TextField(decoration: InputDecoration(labelText: 'Email')),
            TextField(decoration: InputDecoration(labelText: 'Password')),
            TextField(
              decoration: InputDecoration(labelText: 'Confirm Password'),
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
            ElevatedButton(onPressed: () {}, child: Text('Create Account')),
          ],
        ),
      ),
    );
  }
}
