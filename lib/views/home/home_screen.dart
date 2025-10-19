import 'package:flutter/material.dart';
import 'package:pokedex_assessment/core/routes/app_router.dart';
import 'package:pokedex_assessment/viewmodels/auth_viewmodel.dart';
import 'package:pokedex_assessment/viewmodels/pokemon_viewmodel.dart';
import 'package:pokedex_assessment/viewmodels/theme_viewmodel.dart';
import 'package:pokedex_assessment/views/favorites/favorites_screen.dart';
import 'package:pokedex_assessment/views/profile/profile_screen.dart';
import 'package:pokedex_assessment/views/pokemon/pokemon_screen.dart';
import 'package:pokedex_assessment/views/widgets/profile_tile.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isDrawerOpen = false;
  final List<Widget> _pages = [
    PokemonScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Pokemon Library'),

        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  setState(() {
                    _isDrawerOpen = !_isDrawerOpen;
                  });
                  Scaffold.of(context).openEndDrawer();
                },
                icon: Icon(Icons.search),
              );
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
