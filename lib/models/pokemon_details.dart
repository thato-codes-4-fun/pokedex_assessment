class PokemonDetails {
  final int id;
  final String name;
  final int height;
  final int weight;
  final String imageUrl;
  // final List<String> types;
  // final List<String> abilities;
  // final Map<String, int> stats;

  PokemonDetails({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.imageUrl,
    // required this.types,
    // required this.abilities,
    // required this.stats,
  });

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    return PokemonDetails(
      id: json['id'] ?? 0,
      name: json['name'],
      height: json['height'] ?? 0,

      weight: json['weight'] ?? 0,
      imageUrl: json['sprites']['front_default'] ?? '',
      // types: json['types']?.map((e) => e['name']).toList() ?? [],
      // abilities: json['abilities']?.map((e) => e['name']).toList() ?? [],
      // stats: json['stats']?.map((e) => e['base_stat']).toList() ?? [],
    );
  }
}
