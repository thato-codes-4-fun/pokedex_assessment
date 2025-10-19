import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex_assessment/models/pokemon.dart';

class PokemonService {
  static const String baseUrl = 'https://pokeapi.co/api/v2/';

  static Future<List<Pokemon>> getPokemons() async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon'));
    final data = json.decode(response.body);
    return data.map((e) => Pokemon.fromJson(e)).toList();
  }
}
