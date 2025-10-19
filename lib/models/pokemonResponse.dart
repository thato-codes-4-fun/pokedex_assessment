import 'package:pokedex_assessment/models/pokemon.dart';

class PokemonResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<Pokemon> results;

  PokemonResponse({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory PokemonResponse.fromJson(Map<String, dynamic> json) {
    return PokemonResponse(
      count: json['count'] ?? 0,
      next: json['next'] ?? '',
      previous: json['previous'] ?? '',
      results:
          (json['results'] as List<dynamic>?)
              ?.map((e) => Pokemon.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
