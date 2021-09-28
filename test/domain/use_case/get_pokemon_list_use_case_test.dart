import 'package:domain/model/pokemon.dart';
import 'package:domain/model/pokemon_listing.dart';
import 'package:domain/repository/pokemon_repository.dart';
import 'package:domain/use_case/get_pokemon_list_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  const offset = 0;
  const itemsPerPage = 1;

  group(
    'Get pokemon list',
    () {
      final mockRepository = MockPokemonRepository();

      final getPokemonListUseCase = GetPokemonListUseCase(
        repository: mockRepository,
      );

      test(
        'Should return empty Pokemon list',
        () async {
          // Arrange

          // Act
          when(
            () => mockRepository.getPokemonList(offset, itemsPerPage),
          ).thenAnswer(
            (_) async => const PokemonListing(
              pokemonList: [],
              totalAmount: 10,
            ),
          );

          final pokemonListing = await getPokemonListUseCase(
            params: const GetPokemonListUseCaseParams(
              offset: offset,
              itemsPerPage: itemsPerPage,
            ),
          );

          // Assert
          expect(pokemonListing.pokemonList, []);
        },
      );
      test(
        'Should return Pokemon list with one Pokemon',
        () async {
          // Arrange
          const pokemon = Pokemon(
            name: 'Blastoise',
          );
          // Act
          when(
            () => mockRepository.getPokemonList(offset, itemsPerPage),
          ).thenAnswer(
            (_) async => const PokemonListing(
              pokemonList: [
                pokemon,
              ],
              totalAmount: 10,
            ),
          );

          final pokemonListing = await getPokemonListUseCase(
            params: const GetPokemonListUseCaseParams(
              offset: offset,
              itemsPerPage: itemsPerPage,
            ),
          );

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
