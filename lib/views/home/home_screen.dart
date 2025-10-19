import 'package:flutter/material.dart';
import 'package:pokedex_assessment/viewmodels/theme_viewmodel.dart';
import 'package:pokedex_assessment/views/favorites/favorites_screen.dart';
import 'package:pokedex_assessment/views/profile/profile_screen.dart';
import 'package:pokedex_assessment/views/pokemon/pokemon_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _pages = [
    PokemonScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeVM = context.watch<ThemeViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          Switch(
            value: themeVM.isDarkMode,
            onChanged: (value) {
              setState(() {
                themeVM.toggleTheme();
              });
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
