import 'package:domain/model/pokemon.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ifood/data/remote/pokemon_remote_data_source/model/pokemon_listing_remote_model.dart';
import 'package:ifood/data/remote/pokemon_remote_data_source/model/pokemon_remote_model.dart';
import 'package:ifood/data/remote/pokemon_remote_data_source/pokemon_remote_data_source_impl.dart';
import 'package:ifood/data/repository/pokemon_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'pokemon_repository_test.mocks.dart';

@GenerateMocks([PokemonRemoteDataSourceImpl])
void main() {
  const offset = 0;
  const itemsPerPage = 1;

  group(
    'Get pokemon list',
    () {
      final mockRemoteDataSource = MockPokemonRemoteDataSourceImpl();

      final repository = PokemonRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
      );

      test(
        'Empty Pokemon list should be returned',
        () async {
          // Arrange

          // Act
          when(mockRemoteDataSource.getPokemonList(offset, itemsPerPage))
              .thenAnswer(
            (realInvocation) async => const PokemonListingRemoteModel(
              pokemonList: [],
              totalAmount: 10,
            ),
          );

          final pokemonListing =
              await repository.getPokemonList(offset, itemsPerPage);

          // Assert
          expect(pokemonListing.pokemonList, []);
        },
      );
      test(
        'Pokemon list should be returned',
        () async {
          // Arrange
          const pokemon = PokemonRemoteModel(
            name: 'Blastoise',
          );
          // Act
          when(mockRemoteDataSource.getPokemonList(offset, itemsPerPage))
              .thenAnswer(
            (realInvocation) async => const PokemonListingRemoteModel(
              pokemonList: [pokemon],
              totalAmount: 10,
            ),
          );

          final pokemonListing =
              await repository.getPokemonList(offset, itemsPerPage);

          // Assert
          expect(
            pokemonListing.pokemonList.first is Pokemon,
            true,
          );

          expect(
            pokemonListing.pokemonList.first.name,
            pokemon.name,
          );
        },
      );
    },
  );
}
