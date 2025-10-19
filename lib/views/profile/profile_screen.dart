import 'package:flutter/material.dart';
import 'package:pokedex_assessment/viewmodels/auth_viewmodel.dart';
import 'package:pokedex_assessment/viewmodels/theme_viewmodel.dart';
import 'package:pokedex_assessment/views/widgets/profile_tile.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _logout() async {
    await context.read<AuthViewModel>().signOut();
  }

  @override
  Widget build(BuildContext context) {
    final themeVM = context.watch<ThemeViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        spacing: 10,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${themeVM.isDarkMode ? 'Dark' : 'Light'} Mode  ',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Switch(
                  value: themeVM.isDarkMode,
                  onChanged: (value) {
                    themeVM.toggleTheme();
                  },
                  activeColor: Colors.red,
                  inactiveTrackColor: Colors.grey,
                ),
              ],
            ),
          ),
          ProfileTile(
            title: 'Logout',
            icon: Icons.logout,
            onTap: () async {
              await showDialog(
                context: context,
                builder: (context) => _ShowLogoutConfirmation(logout: _logout),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ShowLogoutConfirmation extends StatelessWidget {
  const _ShowLogoutConfirmation({required this.logout});
  final Future<void> Function() logout;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Logout'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            logout();
          },
          child: Text('Logout'),
        ),
      ],
    );
  }
}
