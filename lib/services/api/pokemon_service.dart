import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex_assessment/models/pokemon.dart';
import 'package:pokedex_assessment/models/pokemon_details.dart';
import 'package:pokedex_assessment/models/pokemonResponse.dart';

class PokemonService {
  static const String baseUrl = 'https://pokeapi.co/api/v2';

  static Future<PokemonResponse> getPokemonListPaginated(
    int limit,
    int offset,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/pokemon?limit=1000&offset=$offset'),
      );
      final data = response.body;
      return PokemonResponse.fromJson(
        json.decode(data) as Map<String, dynamic>,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<Pokemon> getPokemonDetails(String name) async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon/$name'));
    final data = json.decode(response.body);
    return Pokemon.fromJson(data);
  }

  static Future<PokemonDetails> getPokemonDetailsByUrl(String url) async {
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    return PokemonDetails.fromJson(data);
  }

  static Future<PokemonResponse> searchPokemon(String name) async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon/$name'));
    final data = json.decode(response.body);
    return PokemonResponse.fromJson(data);
  }
}
