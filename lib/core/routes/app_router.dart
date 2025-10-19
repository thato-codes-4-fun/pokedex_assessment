import 'package:flutter/material.dart';
import 'package:pokedex_assessment/views/auth/login_screen.dart';
import 'package:pokedex_assessment/views/home/home_screen.dart';
import 'package:pokedex_assessment/views/pokemon/pokemon_screen.dart';

class AppRouter {
  static const String auth = '/';
  static const String home = '/home';
  static const String pokemonDetails = '/pokemon-details';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case auth:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case pokemonDetails:
        return MaterialPageRoute(builder: (context) => const PokemonScreen());
      default:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
    }
  }
}
