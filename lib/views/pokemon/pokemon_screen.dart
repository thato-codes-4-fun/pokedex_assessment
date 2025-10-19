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
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PokemonViewModel>().getAllPokemons();
    });

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PokemonViewModel>(
      builder: (context, pokemonVM, child) {
        final filteredPokemons = _searchQuery.isEmpty
            ? pokemonVM.pokemons
            : pokemonVM.pokemons
                  .where(
                    (pokemon) =>
                        pokemon.name.toLowerCase().contains(_searchQuery) ||
                        pokemon.id.toString().contains(_searchQuery),
                  )
                  .toList();

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search Pokemon by name or ID...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
              ),
            ),

            // Results count
            if (_searchQuery.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Found ${filteredPokemons.length} Pokemon',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ),
              ),

            // Pokemon List
            Expanded(
              child: pokemonVM.loading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredPokemons.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No Pokemon found',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Try a different search term',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: filteredPokemons.length,
                      itemBuilder: (context, index) {
                        return PokemonTile(
                          pokemon: filteredPokemons[index],
                          onTap: () async {
                            await pokemonVM.getPokemonDetailsByUrl(
                              filteredPokemons[index].url,
                            );
                            if (context.mounted) {
                              Navigator.pushNamed(
                                context,
                                AppRouter.pokemonDetails,
                              );
                            }
                          },
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
