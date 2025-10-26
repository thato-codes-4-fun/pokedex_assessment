import 'package:flutter/material.dart';
import 'package:pokedex_assessment/models/pokemon.dart';
import 'package:pokedex_assessment/services/local/favorite_service.dart';
import 'package:pokedex_assessment/viewmodels/favourite_viewmodel.dart';
import 'package:provider/provider.dart';

class PokemonTile extends StatefulWidget {
  final Pokemon pokemon;
  final VoidCallback onTap;
  const PokemonTile({super.key, required this.pokemon, required this.onTap});

  @override
  State<PokemonTile> createState() => _PokemonTileState();
}

class _PokemonTileState extends State<PokemonTile> {
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavouriteViewModel>(
      builder: (context, favVM, child) {
        final isFavorite = favVM.favoritePokemonsIds.contains(
          widget.pokemon.id,
        );
        return InkWell(
          onTap: widget.onTap,
          child: ListTile(
            dense: true,
            title: Text(widget.pokemon.name),
            // subtitle: Text(widget.pokemon.url),
            leading: Image.network(
              widget.pokemon.getImageUrl,
              fit: BoxFit.contain,
            ),
            trailing: IconButton(
              onPressed: () async {
                await context.read<FavoriteService>().handleFavoritePokemon(
                  widget.pokemon.id,
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isFavorite
                            ? 'Pokemon added to favorites'
                            : 'Pokemon removed from favorites',
                      ),
                    ),
                  );
                }
              },
              icon: Icon(Icons.favorite_border),
              color: isFavorite ? Colors.red : Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
