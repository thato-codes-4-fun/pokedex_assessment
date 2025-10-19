import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_assessment/models/pokemon.dart';
import 'package:pokedex_assessment/models/pokemon_details.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('Pokemon Model', () {
    test('fromJson should create valid pokemon instance', () {
      final json = {
        'name': 'bulbasaur',
        'url': 'https://pokeapi.co/api/v2/pokemon/1/',
      };

      final pokemon = Pokemon.fromJson(json);

      expect(pokemon.name, 'bulbasaur');
      expect(pokemon.url, 'https://pokeapi.co/api/v2/pokemon/1/');
    });
  });

  group('PokemonDetails Model', () {
    test('fromJson should create valid pokemon details instance', () {
      final jsonString = mockPokemonDetailsResponse();
      final json = jsonDecode(jsonString);
      final pokemonDetails = PokemonDetails.fromJson(json);

      expect(pokemonDetails.id, 1);
      expect(pokemonDetails.name, 'bulbasaur');
      expect(pokemonDetails.height, 7);
      expect(pokemonDetails.weight, 69);
      expect(
        pokemonDetails.imageUrl,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
      );
      expect(pokemonDetails.types, ['grass', 'poison']);

      expect(pokemonDetails.abilities, ['overgrow']);
      expect(pokemonDetails.stats, {
        'hp': 45,
        'attack': 49,
        'defense': 49,
        'special-attack': 65,
        'special-defense': 65,
        'speed': 45,
      });
    });

    test('handle missing data gracefully', () {
      final json = {
        'id': 20,
        'name': 'test-pokemon',
        'height': 10,
        'weight': 100,
        'sprites': {'front_default': 'https://example.com/image.png'},
        'types': [
          {
            'type': {'name': 'normal'},
          },
        ],
        'abilities': [
          {
            'ability': {'name': 'run-away'},
          },
        ],
        'stats': [
          {
            'stat': {'name': 'hp'},
            'base_stat': 50,
          },
          {
            'stat': {'name': 'attack'},
            'base_stat': 50,
          },
          {
            'stat': {'name': 'defense'},
            'base_stat': 50,
          },
          {
            'stat': {'name': 'special-attack'},
            'base_stat': 50,
          },
          {
            'stat': {'name': 'special-defense'},
            'base_stat': 50,
          },
          {
            'stat': {'name': 'speed'},
            'base_stat': 50,
          },
        ],
      };

      final pokemonDetails = PokemonDetails.fromJson(json);

      expect(pokemonDetails.id, 20);
      expect(pokemonDetails.name, 'test-pokemon');
      expect(pokemonDetails.height, 10);
      expect(pokemonDetails.weight, 100);
      expect(pokemonDetails.imageUrl, 'https://example.com/image.png');
      expect(pokemonDetails.types, ['normal']);
      expect(pokemonDetails.abilities, ['run-away']);
      expect(pokemonDetails.stats['hp'], 50);
      expect(pokemonDetails.stats['attack'], 50);
    });

    test('handles empty optional fields', () {
      final json = {
        'id': 999,
        'name': 'minimal-pokemon',
        'height': 5,
        'weight': 25,
        'sprites': {'front_default': null},
        'types': [],
        'abilities': [],
        'stats': [],
      };

      final pokemonDetails = PokemonDetails.fromJson(json);

      expect(pokemonDetails.types, isEmpty);
      expect(pokemonDetails.abilities, isEmpty);
      expect(pokemonDetails.stats, isEmpty);
      expect(pokemonDetails.imageUrl, '');
    });
  });
}
