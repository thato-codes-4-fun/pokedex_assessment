import 'package:hive_flutter/hive_flutter.dart';

class FavoriteService {
  final Box box;
  FavoriteService(this.box);
  static const String _boxName = 'favoritesBox';
  static const String key = 'favoritePokemonsIds';

  // factory constructor for prod
  static Future<FavoriteService> create() async {
    final box = await Hive.openBox(_boxName);
    return FavoriteService(box);
  }

  Future<List<int>> getFavoritePokemonsIds() async {
    final data = box.get(key, defaultValue: []);
    return data is List<int> ? data : [];
  }

  Future<void> addFavoritePokemon(int id) async {
    final favoritePokemonsIds = await getFavoritePokemonsIds();
    if (!favoritePokemonsIds.contains(id)) {
      favoritePokemonsIds.add(id);
      await box.put(key, favoritePokemonsIds);
    }
  }

  Future<void> removeFavoritePokemon(int id) async {
    final favoritePokemonsIds = await getFavoritePokemonsIds();
    if (favoritePokemonsIds.contains(id)) {
      favoritePokemonsIds.remove(id);
      await box.put(key, favoritePokemonsIds);
    }
  }

  Future<bool> handleFavoritePokemon(int id) async {
    final isFavorite = await getFavoritePokemonsIds();
    if (isFavorite.contains(id)) {
      await removeFavoritePokemon(id);
      return false;
    } else {
      await addFavoritePokemon(id);
      return true;
    }
  }

  Future<void> clearFavorites() async {
    await box.clear();
  }
}
