import 'package:domain/model/pokemon.dart';
import 'package:domain/model/pokemon_listing.dart';
import 'package:domain/use_case/get_pokemon_list_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ifood/data/repository/pokemon_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_pokemon_list_use_case_test.mocks.dart';

@GenerateMocks([PokemonRepositoryImpl])
void main() {
  const offset = 0;
  const itemsPerPage = 1;

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
          when(mockPokemonRepository.getPokemonList(offset, itemsPerPage))
              .thenAnswer(
            (realInvocation) async => const PokemonListing(
              pokemonList: [],
              totalAmount: 10,
            ),
          );

          final pokemonListing = await getPokemonListUseCase();

          // Assert
          expect(pokemonListing.pokemonList, []);
        },
      );
      test(
        'Pokemon list should be returned',
        () async {
          // Arrange
          const pokemon = Pokemon(
            name: 'Blastoise',
          );
          // Act
          when(mockPokemonRepository.getPokemonList(offset, itemsPerPage))
              .thenAnswer(
            (realInvocation) async => const PokemonListing(
              pokemonList: [
                pokemon,
              ],
              totalAmount: 10,
            ),
          );

          final pokemonListing = await getPokemonListUseCase();

          // Assert
          expect(
            pokemonListing.pokemonList,
            [pokemon],
          );
        },
      );
    },
  );
}
