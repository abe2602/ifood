import 'package:domain/model/pokemon.dart';
import 'package:domain/use_case/get_pokemon_list_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ifood/data/repository/pokemon_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_pokemon_list_use_case_test.mocks.dart';

@GenerateMocks([PokemonRepositoryImpl])
void main() {
  group(
    'Get pokemon list',
    () {
      final mockPokemonRepository = MockPokemonRepositoryImpl();

      final getPokemonListUseCase = GetPokemonListUseCase(
        repository: mockPokemonRepository,
      );

      test(
        'Empty Pokemon list should be returned',
        () async {
          // Arrange

          // Act
          when(mockPokemonRepository.getPokemonList()).thenAnswer(
            (realInvocation) async => [],
          );

          final pokemonList = await getPokemonListUseCase();

          // Assert
          expect(pokemonList, []);
        },
      );
      test(
        'Pokemon list should be returned',
        () async {
          // Arrange
          const pokemon =  Pokemon(
            name: 'Blastoise',
          );
          // Act
          when(mockPokemonRepository.getPokemonList()).thenAnswer(
            (realInvocation) async => const [
              pokemon
            ],
          );

          final pokemonList = await getPokemonListUseCase();

          // Assert
          expect(pokemonList, [pokemon]);
        },
      );
    },
  );
}
