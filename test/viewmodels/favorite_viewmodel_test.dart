// test/viewmodels/favourite_viewmodel_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex_assessment/models/pokemon_details.dart';
import 'package:pokedex_assessment/services/local/favorite_service.dart';
import 'package:pokedex_assessment/viewmodels/favourite_viewmodel.dart';

class MockFavoriteService extends Mock implements FavoriteService {}

class MockPokemonDetails extends Mock implements PokemonDetails {}

void main() {
  group('FavouriteViewModel Tests', () {
    late MockFavoriteService mockFavoriteService;
    late FavouriteViewModel viewModel;

    setUp(() {
      mockFavoriteService = MockFavoriteService();
      viewModel = FavouriteViewModel(mockFavoriteService);
    });

    test('initial state is correct', () {
      expect(viewModel.favoritePokemonsIds, isEmpty);
      expect(viewModel.favoritePokemons, isEmpty);
      expect(viewModel.loading, isFalse);
      expect(viewModel.count, 0);
    });

    group('loadFavorites', () {
      test('updates loading state and notifies listeners', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavoritePokemonsIds(),
        ).thenAnswer((_) async => [1, 2]);

        // Act
        await viewModel.loadFavorites();

        // Assert
        expect(viewModel.loading, isFalse); // Should be false after loading
        expect(viewModel.favoritePokemonsIds, [1, 2]);
      });

      test('handles errors gracefully', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavoritePokemonsIds(),
        ).thenThrow(Exception('Network error'));

        // Act
        await viewModel.loadFavorites();

        // Assert
        expect(viewModel.loading, isFalse); // Should reset loading state
        expect(viewModel.favoritePokemonsIds, isEmpty);
      });
    });

    group('isFavorite', () {
      test('returns true when pokemon is in favorites', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavoritePokemonsIds(),
        ).thenAnswer((_) async => [1, 2, 3]);
        await viewModel.loadFavorites();

        // Act & Assert
        expect(viewModel.isFavorite(2), isTrue);
        expect(viewModel.isFavorite(4), isFalse);
      });
    });

    group('toggleFavorite', () {
      test('calls service and reloads favorites', () async {
        // Arrange
        when(
          () => mockFavoriteService.handleFavoritePokemon(any()),
        ).thenAnswer((_) async => true);
        when(
          () => mockFavoriteService.getFavoritePokemonsIds(),
        ).thenAnswer((_) async => [1]);

        // Act
        await viewModel.toggleFavorite(1);

        // Assert
        verify(() => mockFavoriteService.handleFavoritePokemon(1)).called(1);
        expect(viewModel.favoritePokemonsIds, [1]);
      });
    });

    group('addFavorite', () {
      test('adds pokemon and reloads favorites', () async {
        // Arrange
        when(
          () => mockFavoriteService.addFavoritePokemon(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockFavoriteService.getFavoritePokemonsIds(),
        ).thenAnswer((_) async => [1]);

        // Act
        await viewModel.addFavorite(1);

        // Assert
        verify(() => mockFavoriteService.addFavoritePokemon(1)).called(1);
        expect(viewModel.favoritePokemonsIds, [1]);
      });
    });

    group('removeFavorite', () {
      test('removes pokemon and reloads favorites', () async {
        // Arrange
        when(
          () => mockFavoriteService.removeFavoritePokemon(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockFavoriteService.getFavoritePokemonsIds(),
        ).thenAnswer((_) async => []);

        // Act
        await viewModel.removeFavorite(1);

        // Assert
        verify(() => mockFavoriteService.removeFavoritePokemon(1)).called(1);
        expect(viewModel.favoritePokemonsIds, isEmpty);
      });
    });
  });
}
