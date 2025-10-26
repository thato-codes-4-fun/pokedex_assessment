import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex_assessment/services/local/favorite_service.dart';

import '../mocks/mock_service.dart';

void main() {
  group('FavoriteService Tests', () {
    late MockBox mockBox;
    late FavoriteService favoriteService;

    setUp(() {
      mockBox = MockBox();
      favoriteService = FavoriteService(mockBox);
    });

    group('getFavoritePokemonsIds', () {
      test('returns empty list when no favorite pokemons are saved', () async {
        // Arrange: Setup mock to return empty list
        when(
          () => mockBox.get(any(), defaultValue: any(named: 'defaultValue')),
        ).thenReturn([]);

        // Act: Call the method
        final result = await favoriteService.getFavoritePokemonsIds();

        // Assert: Verify it returns empty list
        expect(result, isEmpty);
        expect(result, isA<List<int>>());

        // Verify the mock was called
        verify(
          () => mockBox.get(any(), defaultValue: any(named: 'defaultValue')),
        ).called(1);
      });

      test('returns list of favorites when they exist', () async {
        // Arrange
        final mockFavorites = [1, 25, 150];
        when(
          () => mockBox.get(any(), defaultValue: any(named: 'defaultValue')),
        ).thenReturn(mockFavorites);

        // Act
        final result = await favoriteService.getFavoritePokemonsIds();

        // Assert
        expect(result, equals(mockFavorites));
        expect(result.length, 3);
      });
    });

    group('addFavoritePokemon', () {
      test('should add favorite pokemon id', () async {
        // Arrange: Setup mocks
        when(
          () => mockBox.get(any(), defaultValue: any(named: 'defaultValue')),
        ).thenReturn([]);

        when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

        // Act
        await favoriteService.addFavoritePokemon(1);

        // Assert: Verify put was called with [1]
        final saved =
            verify(() => mockBox.put(any(), captureAny())).captured.single
                as List<int>;
        expect(saved, [1]);
        expect(saved.length, 1);
      });

      test('should not add duplicate pokemon id', () async {
        // Arrange: Pokemon already exists in favorites
        when(
          () => mockBox.get(any(), defaultValue: any(named: 'defaultValue')),
        ).thenReturn([1]);

        when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

        // Act
        await favoriteService.addFavoritePokemon(1);

        // Assert: put should never be called (no duplicates)
        verifyNever(() => mockBox.put(any(), any()));
      });
    });

    group('removeFavoritePokemon', () {
      test('should remove favorite pokemon id', () async {
        // Arrange
        when(
          () => mockBox.get(any(), defaultValue: any(named: 'defaultValue')),
        ).thenReturn([1]);

        when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

        // Act
        await favoriteService.removeFavoritePokemon(1);

        // Assert: Verify empty list was saved
        final saved =
            verify(() => mockBox.put(any(), captureAny())).captured.single
                as List<int>;
        expect(saved, isEmpty);
      });

      test('should do nothing if pokemon id not in favorites', () async {
        // Arrange
        when(
          () => mockBox.get(any(), defaultValue: any(named: 'defaultValue')),
        ).thenReturn([2]); // Different ID

        when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

        // Act
        await favoriteService.removeFavoritePokemon(1);

        // Assert: put should never be called
        verifyNever(() => mockBox.put(any(), any()));
      });
    });

    group('handleFavoritePokemon', () {
      test('adds pokemon when not in favorites and returns true', () async {
        // Arrange
        when(
          () => mockBox.get(any(), defaultValue: any(named: 'defaultValue')),
        ).thenReturn([]);

        when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

        // Act
        final result = await favoriteService.handleFavoritePokemon(1);

        // Assert
        expect(result, isTrue);
        final saved =
            verify(() => mockBox.put(any(), captureAny())).captured.single
                as List<int>;
        expect(saved, [1]);
        expect(saved.length, 1);
      });

      test('removes pokemon when in favorites and returns false', () async {
        // Arrange
        when(
          () => mockBox.get(any(), defaultValue: any(named: 'defaultValue')),
        ).thenReturn([1]);

        when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

        // Act
        final result = await favoriteService.handleFavoritePokemon(1);

        // Assert
        expect(result, isFalse);
        final saved =
            verify(() => mockBox.put(any(), captureAny())).captured.single
                as List<int>;
        expect(saved, isEmpty);
      });
    });

    group('clearFavorites', () {
      test('clears all favorites from storage', () async {
        // Arrange
        when(() => mockBox.clear()).thenAnswer((_) async => 0);

        // Act
        await favoriteService.clearFavorites();

        // Assert
        verify(() => mockBox.clear()).called(1);
      });
    });
  });
}
