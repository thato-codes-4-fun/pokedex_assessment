import 'package:flutter/material.dart';
import 'package:pokedex_assessment/views/auth/login_screen.dart';
import 'package:pokedex_assessment/views/auth/register_screen.dart';
import 'package:pokedex_assessment/views/home/home_screen.dart';
import 'package:pokedex_assessment/views/pokemon/pokemon_screen.dart';
import 'package:pokedex_assessment/views/pokemon_details/pokemon_details.dart';

class AppRouter {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String pokemonDetails = '/pokemon-details';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
      case home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      case pokemonDetails:
        return MaterialPageRoute(
          builder: (context) => const PokemonDetailsScreen(),
        );
      default:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
    }
  }
}
