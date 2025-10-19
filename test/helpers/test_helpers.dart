import 'package:pokedex_assessment/models/pokemon.dart';
import 'package:pokedex_assessment/models/pokemon_details.dart';

Pokemon createMockPokemon() {
  int id = 1;
  String name = 'Bulbasaur';
  String url = 'https://pokeapi.co/api/v2/pokemon/1/';
  return Pokemon(name: name, url: url);
}

PokemonDetails createMockPokemonDetails(int id, String name) {
  return PokemonDetails(
    id: id,
    name: name,
    height: 7,
    weight: 69,
    imageUrl:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
    types: ['grass', 'poison'],
    abilities: ['overgrow', 'chlorophyll'],
    stats: {
      'hp': 45,
      'attack': 49,
      'defense': 49,
      'special-attack': 65,
      'special-defense': 65,
      'speed': 45,
    },
  );
}

String mockPokemonListResponse() {
  return '''
{
  "count": 1302,
  "next": "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
  "previous": null,
  "results": [
    {
      "name": "bulbasaur",
      "url": "https://pokeapi.co/api/v2/pokemon/1/"
    },
    {
      "name": "ivysaur",
      "url": "https://pokeapi.co/api/v2/pokemon/2/"
    }
  ]
}
''';
}

String mockPokemonDetailsResponse({int id = 1}) {
  return '''
  {
    "id": $id,
    "name": "bulbasaur",
    "height": 7,
    "weight": 69,
    "sprites": {
      "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png"
    },
    "types": [
      {
        "slot": 1,
        "type": {
          "name": "grass",
          "url": "https://pokeapi.co/api/v2/type/12/"
        }
      },
      {
        "slot": 2,
        "type": {
          "name": "poison",
          "url": "https://pokeapi.co/api/v2/type/4/"
        }
      }
    ],
    "abilities": [
      {
        "ability": {
          "name": "overgrow",
          "url": "https://pokeapi.co/api/v2/ability/65/"
        },
        "is_hidden": false,
        "slot": 1
      }
    ],
    "stats": [
      {"base_stat": 45, "stat": {"name": "hp"}},
      {"base_stat": 49, "stat": {"name": "attack"}},
      {"base_stat": 49, "stat": {"name": "defense"}},
      {"base_stat": 65, "stat": {"name": "special-attack"}},
      {"base_stat": 65, "stat": {"name": "special-defense"}},
      {"base_stat": 45, "stat": {"name": "speed"}}
    ]
  }
  ''';
}
