import 'package:domain/repository/pokemon_repository.dart';
import 'package:domain/use_case/release_pokemon_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  test(
    'Should release pokémon',
    () async {
      // Arrange
      final mockRepository = MockPokemonRepository();

      final releasePokemonUseCase = ReleasePokemonUseCase(
        repository: mockRepository,
      );

      const pokemonName = 'blastoise';

      // Act
      when(
        () => mockRepository.releasePokemon(pokemonName),
      ).thenAnswer(
        (_) async => {},
      );

      await releasePokemonUseCase();

      // Assert
    },
  );
}
