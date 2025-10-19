import 'package:flutter/material.dart';
import 'package:pokedex_assessment/models/pokemon.dart';
import 'package:pokedex_assessment/services/api/pokemon_service.dart';

class PokemonViewModel extends ChangeNotifier {
  List<Pokemon> _pokemons = [];
  Pokemon? _selectedPokemon;
  int _limit = 10;
  int _offset = 0;
  bool _loading = false;

  List<Pokemon> get pokemons => _pokemons;
  Pokemon? get selectedPokemon => _selectedPokemon;
  set selectedPokemon(Pokemon? value) {
    _selectedPokemon = value;
    notifyListeners();
  }

  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  int get limit => _limit;
  set limit(int value) {
    _limit = value;
    notifyListeners();
  }

  int get offset => _offset;
  set offset(int value) {
    _offset = value;
    notifyListeners();
  }

  void nextPage() {
    offset = offset + limit;
    getAllPokemons();
  }

  void previousPage() {
    offset = offset - limit;
    getAllPokemons();
  }

  Future<void> getAllPokemons() async {
    try {
      loading = true;
      final pokemons = await PokemonService.getPokemonListPaginated(
        _limit,
        _offset,
      );
      _pokemons = pokemons.results;
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    } finally {
      loading = false;
    }
  }

  Future<void> getPokemonDetails(String name) async {
    try {
      loading = true;
      final pokemon = await PokemonService.getPokemonDetails(name);
      selectedPokemon = pokemon;
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    } finally {
      loading = false;
    }
  }
}
