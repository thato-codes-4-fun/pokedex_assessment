import 'package:flutter/material.dart';
import 'package:pokedex_assessment/models/pokemon_details.dart';
import 'package:pokedex_assessment/services/local/favorite_service.dart';
import 'package:pokedex_assessment/services/api/pokemon_service.dart';

class FavouriteViewModel extends ChangeNotifier {
  List<int> _favoritePokemonsIds = [];
  List<PokemonDetails> _favoritePokemons = [];
  bool _loading = false;

  List<int> get favoritePokemonsIds => _favoritePokemonsIds;
  List<PokemonDetails> get favoritePokemons => _favoritePokemons;
  bool get loading => _loading;
  int get count => _favoritePokemonsIds.length;

  FavouriteViewModel() {
    loadFavorites();
  }

  bool isFavorite(int pokemonId) {
    return _favoritePokemonsIds.contains(pokemonId);
  }

  Future<void> loadFavorites() async {
    try {
      _loading = true;
      notifyListeners();

      _favoritePokemonsIds = await FavoriteService.getFavoritePokemonsIds();

      await loadFavoriteDetails();
    } catch (e) {
      print('Error loading favorites: $e');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> loadFavoriteDetails() async {
    if (_favoritePokemonsIds.isEmpty) {
      _favoritePokemons = [];
      notifyListeners();
      return;
    }

    try {
      _favoritePokemons = [];

      for (final id in _favoritePokemonsIds) {
        try {
          final url = 'https://pokeapi.co/api/v2/pokemon/$id';
          final details = await PokemonService.getPokemonDetailsByUrl(url);
          _favoritePokemons.add(details);
        } catch (e) {
          print('Error loading favorite Pokemon $id: $e');
        }
      }

      notifyListeners();
    } catch (e) {
      print('Error loading favorite details: $e');
    }
  }

  Future<void> toggleFavorite(int pokemonId) async {
    await FavoriteService.handleFavoritePokemon(pokemonId);
    await loadFavorites();
  }

  Future<void> addFavorite(int pokemonId) async {
    await FavoriteService.addFavoritePokemon(pokemonId);
    await loadFavorites();
  }

  Future<void> removeFavorite(int pokemonId) async {
    await FavoriteService.removeFavoritePokemon(pokemonId);
    await loadFavorites();
  }
}
