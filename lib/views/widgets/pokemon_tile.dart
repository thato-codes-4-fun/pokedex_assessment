import 'package:flutter/material.dart';
import 'package:http/http.dart' as context;
import 'package:pokedex_assessment/models/pokemon.dart';
import 'package:pokedex_assessment/viewmodels/pokemon_viewmodel.dart';

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
    return ListTile(
      dense: true,
      title: Text(widget.pokemon.name),
      subtitle: Text(widget.pokemon.url),
      leading: Image.network(widget.pokemon.getImageUrl),
      trailing: IconButton(
        onPressed: widget.onTap,
        icon: Icon(Icons.favorite_border),
        color: Colors.red,
      ),
    );
  }
}
