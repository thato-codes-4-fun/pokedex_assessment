import 'package:flutter/material.dart';
import 'package:pokedex_assessment/viewmodels/pokemon_viewmodel.dart';
import 'package:provider/provider.dart';

class PokemonScreen extends StatefulWidget {
  const PokemonScreen({super.key});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PokemonViewModel>().getAllPokemons();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PokemonViewModel>(
      builder: (context, pokemonVM, child) {
        return pokemonVM.loading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: pokemonVM.pokemons.length,
                itemBuilder: (context, index) {
                  return Text(pokemonVM.pokemons[index].name);
                },
              );
      },
    );
  }
}
