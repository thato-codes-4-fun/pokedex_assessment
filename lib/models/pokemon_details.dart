class PokemonDetails {
  final int id;
  final String name;
  final int height;
  final int weight;
  final String imageUrl;
  final List<String> types;
  final List<String> abilities;
  final Map<String, int> stats;

  PokemonDetails({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.imageUrl,
    required this.types,
    required this.abilities,
    required this.stats,
  });

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    final List<String> typesList = [];
    if (json['types'] != null) {
      for (var typeData in json['types'] as List) {
        typesList.add(typeData['type']['name'] as String);
      }
    }

    final List<String> abilitiesList = [];
    if (json['abilities'] != null) {
      for (var abilityData in json['abilities'] as List) {
        abilitiesList.add(abilityData['ability']['name'] as String);
      }
    }

    final Map<String, int> statsMap = {};
    if (json['stats'] != null) {
      for (var statData in json['stats'] as List) {
        final statName = statData['stat']['name'] as String;
        final baseStat = statData['base_stat'] as int;
        statsMap[statName] = baseStat;
      }
    }

    return PokemonDetails(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      imageUrl: json['sprites']?['front_default'] ?? '',
      types: typesList,
      abilities: abilitiesList,
      stats: statsMap,
    );
  }

  String get typesDisplay => types.join(', ');

  String get abilitiesDisplay => abilities.join(', ');
  int get hp => stats['hp'] ?? 0;
  int get attack => stats['attack'] ?? 0;
  int get defense => stats['defense'] ?? 0;
  int get specialAttack => stats['special-attack'] ?? 0;
  int get specialDefense => stats['special-defense'] ?? 0;
  int get speed => stats['speed'] ?? 0;
}
