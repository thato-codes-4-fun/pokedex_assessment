import 'package:flutter/material.dart';
import 'package:pokedex_assessment/models/pokemon.dart';
import 'package:pokedex_assessment/models/pokemon_details.dart';
import 'package:pokedex_assessment/services/api/pokemon_service.dart';

class PokemonViewModel extends ChangeNotifier {
  List<Pokemon> _pokemons = [];
  List<PokemonDetails> _pokemonDetails = [];
  PokemonDetails? _pokemonDetail;
  final Map<int, PokemonDetails> _detailsCache = {};
  Pokemon? _selectedPokemon;
  int _limit = 10;
  int _offset = 0;
  bool _loading = false;
  bool _loadingDetails = false;

  List<Pokemon> get pokemons => _pokemons;
  Pokemon? get selectedPokemon => _selectedPokemon;
  bool get loading => _loading;
  bool get loadingDetails => _loadingDetails;
  int get limit => _limit;
  int get offset => _offset;
  PokemonDetails? get pokemonDetail => _pokemonDetail;
  Map<int, PokemonDetails> get detailsCache => _detailsCache;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  set selectedPokemon(Pokemon? value) {
    _selectedPokemon = value;
    notifyListeners();
  }

  set pokemonDetail(PokemonDetails? value) {
    _pokemonDetail = value;
    notifyListeners();
  }

  set limit(int value) {
    _limit = value;
    notifyListeners();
  }

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

  Future<PokemonDetails?> getPokemonDetailsByUrl(String url) async {
    final parts = url.split('/');
    final id = int.tryParse(parts[parts.length - 2]) ?? 0;
    if (id == 0) {
      return null;
    }
    if (detailsCache.containsKey(id)) {
      return detailsCache[id];
    }

    try {
      _loadingDetails = true;
      final pokemon = await PokemonService.getPokemonDetailsByUrl(url);
      detailsCache[id] = pokemon;
      _pokemonDetail = pokemon;
      notifyListeners();
      return pokemon;
    } catch (e) {
      return null;
    } finally {
      _loadingDetails = false;
      notifyListeners();
    }
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
