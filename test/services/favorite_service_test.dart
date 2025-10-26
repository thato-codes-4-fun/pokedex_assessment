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

        // Optional: Verify the mock was called
        verify(
          () => mockBox.get(any(), defaultValue: any(named: 'defaultValue')),
        ).called(1);
      });
      // add favorite pokemon id
    });
    // ... existing code ...

    group('addFavoritePokemon', () {
      test('should add favorite pokemon id', () async {
        // <-- The 'test' block starts here
        // Arrange: Setup mock for get
        when(
          () => mockBox.get(
            FavoriteService.key,
            defaultValue: any(named: 'defaultValue'),
          ),
        ).thenReturn([]);

        // Arrange: Setup mock for put (needs to be inside this test block)
        when(
          () => mockBox.put(FavoriteService.key, any()),
        ).thenAnswer((_) async {}); // Use thenAnswer for Future<void>

        // Act: Call the method (with await)
        await favoriteService.addFavoritePokemon(1); // <-- Added 'await'

        // Assert: Verify put was called with [1]
        verify(() => mockBox.put(FavoriteService.key, [1])).called(1);
      }); // <-- The 'test' block ends here
    }); // <-- The 'group' block for addFavoritePokemon ends here

    // ... existing code ...
    // remove favorite pokemon id
    group('removeFavoritePokemon', () {
      test('should remove favorite pokemon id', () async {
        // Arrange
        when(
          () => mockBox.get(
            FavoriteService.key,
            defaultValue: any(named: 'defaultValue'),
          ),
        ).thenReturn([1]);

        when(
          () => mockBox.put(FavoriteService.key, any()),
        ).thenAnswer((_) async {});

        // Act
        await favoriteService.removeFavoritePokemon(1);

        // Assert: was called once
        verify(() => mockBox.put(FavoriteService.key, any())).called(1);

        // And the saved value is an empty list
        final saved =
            verify(
                  () => mockBox.put(FavoriteService.key, captureAny()),
                ).captured.single
                as List<int>;
        expect(saved, isEmpty);
      });
    });
    // handle favorite pokemon
    group('handleFavoritePokemon', () {
      test('should add favorite pokemon id', () async {
        // Arrange: Setup mock to return empty list
        when(
          () => mockBox.get(
            FavoriteService.key,
            defaultValue: any(named: 'defaultValue'),
          ),
        ).thenReturn([]);
        when(
          () => mockBox.put(FavoriteService.key, any()),
        ).thenAnswer((_) async => {});
        // Act: Call the method
        favoriteService.handleFavoritePokemon(1);

        // Assert: Verify put was called with [1]
        verify(() => mockBox.put(FavoriteService.key, [1])).called(1);
      });
    });
  });
}
