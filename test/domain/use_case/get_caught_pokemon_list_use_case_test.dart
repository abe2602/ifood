import 'package:domain/model/pokemon.dart';
import 'package:domain/repository/pokemon_repository.dart';
import 'package:domain/use_case/get_caught_pokemon_list_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  group(
    'Get pokemon list',
    () {
      final mockRepository = MockPokemonRepository();

      final getCaughtPokemonListUseCase = GetCaughtPokemonListUseCase(
        repository: mockRepository,
      );

      test(
        'Should return empty caught Pokemon list',
        () async {
          // Arrange

          // Act
          when(
            () => mockRepository.getCaughtPokemonList(),
          ).thenAnswer(
            (_) async => [],
          );

          final pokemonList = await getCaughtPokemonListUseCase();

          // Assert
          expect(pokemonList, []);
        },
      );

      test(
        'Should return caught Pokemon list with one Pokemon',
        () async {
          // Arrange
          const pokemon = Pokemon(
            name: 'Blastoise',
          );

          // Act
          when(
            () => mockRepository.getCaughtPokemonList(),
          ).thenAnswer(
            (_) async => [
              pokemon,
            ],
          );

          final pokemonList = await getCaughtPokemonListUseCase();

          // Assert
          expect(
            pokemonList,
            [
              pokemon,
            ],
          );
        },
      );
    },
  );
}
