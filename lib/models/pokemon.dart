class Pokemon {
  final String name;
  final String url;

  Pokemon({required this.name, required this.url});

  // "https://pokeapi.co/api/v2/pokemon/3/"

  int get id =>
      int.tryParse(url.split('/').where((e) => e.isNotEmpty).last) ?? 0;

  String get getImageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(name: json['name'], url: json['url']);
  }
}
