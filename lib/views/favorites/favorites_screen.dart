import 'package:flutter/material.dart';
import 'package:pokedex_assessment/core/routes/app_router.dart';
import 'package:pokedex_assessment/services/local/favorite_service.dart';
import 'package:pokedex_assessment/viewmodels/favourite_viewmodel.dart';
import 'package:pokedex_assessment/viewmodels/pokemon_viewmodel.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavouriteViewModel>().loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavouriteViewModel>(
      builder: (context, favVM, child) {
        if (favVM.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (favVM.favoritePokemons.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_border, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'No Favorite Pokemon',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Text(
                  'Add Pokemon to favorites by tapping the heart icon',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => favVM.loadFavorites(),
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: favVM.favoritePokemons.length,
            itemBuilder: (context, index) {
              final pokemon = favVM.favoritePokemons[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: Image.network(
                    pokemon.imageUrl,
                    width: 60,
                    height: 60,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.catching_pokemon, size: 60);
                    },
                  ),
                  title: Text(
                    pokemon.name.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(pokemon.types.join(', ').toUpperCase()),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () async {
                      await FavoriteService.handleFavoritePokemon(pokemon.id);
                    },
                  ),
                  onTap: () async {
                    await context
                        .read<PokemonViewModel>()
                        .getPokemonDetailsByUrl(
                          'https://pokeapi.co/api/v2/pokemon/${pokemon.id}',
                        );
                    if (context.mounted) {
                      Navigator.pushNamed(context, AppRouter.pokemonDetails);
                    }
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
