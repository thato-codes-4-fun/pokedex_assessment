import 'package:flutter/material.dart';
import 'package:pokedex_assessment/viewmodels/pokemon_viewmodel.dart';
import 'package:provider/provider.dart';

class PokemonDetailsScreen extends StatefulWidget {
  const PokemonDetailsScreen({super.key});

  @override
  State<PokemonDetailsScreen> createState() => _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends State<PokemonDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pokemon Details')),
      body: Consumer<PokemonViewModel>(
        builder: (context, pokemonVM, child) {
          return pokemonVM.pokemonDetail == null
              ? const Center(child: CircularProgressIndicator())
              : Center(child: Text(pokemonVM.pokemonDetail!.name));
        },
      ),
    );
  }
}
