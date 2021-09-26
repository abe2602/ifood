import 'package:domain/model/pokemon.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ifood/data/remote/pokemon_remote_data_source/model/pokemon_remote_model.dart';
import 'package:ifood/data/remote/pokemon_remote_data_source/pokemon_remote_data_source_impl.dart';
import 'package:ifood/data/repository/pokemon_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'pokemon_repository_test.mocks.dart';


@GenerateMocks([PokemonRemoteDataSourceImpl])
void main() {
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
          when(mockRemoteDataSource.getPokemonList()).thenAnswer(
            (realInvocation) async => [],
          );

          final pokemonList = await repository.getPokemonList();

          // Assert
          expect(pokemonList, []);
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
          when(mockRemoteDataSource.getPokemonList()).thenAnswer(
            (realInvocation) async => const [pokemon],
          );

          final pokemonList = await repository.getPokemonList();

          // Assert
          expect(
            pokemonList.first is Pokemon,
            true,
          );

          expect(
            pokemonList.first.name,
            pokemon.name,
          );
        },
      );
    },
  );
}
