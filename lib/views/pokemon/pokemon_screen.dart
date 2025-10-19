import 'package:flutter/material.dart';
import 'package:pokedex_assessment/core/routes/app_router.dart';
import 'package:pokedex_assessment/viewmodels/pokemon_viewmodel.dart';
import 'package:pokedex_assessment/views/widgets/pokemon_tile.dart';
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
                  return PokemonTile(
                    pokemon: pokemonVM.pokemons[index],
                    onTap: () async {
                      await pokemonVM.getPokemonDetailsByUrl(
                        pokemonVM.pokemons[index].url,
                      );
                      if (context.mounted) {
                        Navigator.pushNamed(context, AppRouter.pokemonDetails);
                      }
                    },
                  );
                },
              );
      },
    );
  }
}
