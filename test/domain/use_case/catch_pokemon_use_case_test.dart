import 'package:domain/repository/pokemon_repository.dart';
import 'package:domain/use_case/catch_pokemon_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  test(
    'Should catch pokémon',
    () async {
      // Arrange
      final mockRepository = MockPokemonRepository();

      final catchPokemonUseCase = CatchPokemonUseCase(
        repository: mockRepository,
      );

      const pokemonName = 'blastoise';

      // Act
      when(
        () => mockRepository.catchPokemon(pokemonName),
      ).thenAnswer(
        (_) async => {},
      );

      await catchPokemonUseCase();

      // Assert
    },
  );
}
