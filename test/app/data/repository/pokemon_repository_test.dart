import 'package:domain/model/pokemon.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ifood/data/remote/pokemon_remote_data_source/model/pokemon_detail_remote_model.dart';
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

  final mockRemoteDataSource = MockPokemonRemoteDataSourceImpl();

  final repository = PokemonRepositoryImpl(
    remoteDataSource: mockRemoteDataSource,
  );

  group(
    'Get pokemon list',
    () {
      test(
        'Should return empty Pokemon list',
        () async {
          // Arrange

          // Act
          when(mockRemoteDataSource.getPokemonList(offset, itemsPerPage))
              .thenAnswer(
            (_) async => const PokemonListingRemoteModel(
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
        'Should return Pokemon list with one Pokémon',
        () async {
          // Arrange
          const pokemon = PokemonRemoteModel(
            name: 'Blastoise',
          );
          // Act
          when(mockRemoteDataSource.getPokemonList(offset, itemsPerPage))
              .thenAnswer(
            (_) async => const PokemonListingRemoteModel(
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

  group(
    'Get pokemon detail',
    () {
      test(
        'Should return Pokemon with name Blastoise',
            () async {
          // Arrange
          const pokemonDetailRemoteModel = PokemonDetailRemoteModel(
            name: 'Blastoise',
          );

          // Act
          when(mockRemoteDataSource.getPokemonDetail('blastoise'))
              .thenAnswer(
                (_) async => pokemonDetailRemoteModel,
          );

          final pokemonDetail = await repository.getPokemonDetail('blastoise');

          // Assert
          expect(
            pokemonDetail.name,
            pokemonDetailRemoteModel.name,
          );
        },
      );
    },
  );
}
