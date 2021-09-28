import 'package:domain/model/pokemon.dart';
import 'package:domain/model/pokemon_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ifood/data/local/cache/pokemon_cache_data_source/model/pokemon_cache_model.dart';
import 'package:ifood/data/local/cache/pokemon_cache_data_source/model/pokemon_status_cache_model.dart';
import 'package:ifood/data/local/cache/pokemon_cache_data_source/pokemon_cache_data_source.dart';
import 'package:ifood/data/remote/pokemon_remote_data_source/model/pokemon_detail_remote_model.dart';
import 'package:ifood/data/remote/pokemon_remote_data_source/model/pokemon_listing_remote_model.dart';
import 'package:ifood/data/remote/pokemon_remote_data_source/model/pokemon_remote_model.dart';
import 'package:ifood/data/remote/pokemon_remote_data_source/pokemon_remote_data_source.dart';
import 'package:ifood/data/repository/pokemon_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockPokemonRemoteDataSource extends Mock
    implements PokemonRemoteDataSource {}

class MockPokemonCacheDataSource extends Mock
    implements PokemonCacheDataSource {}

void main() {
  const offset = 0;
  const itemsPerPage = 1;

  final remoteDataSource = MockPokemonRemoteDataSource();
  final cacheDataSource = MockPokemonCacheDataSource();
  final repository = PokemonRepositoryImpl(
    cacheDataSource: cacheDataSource,
    remoteDataSource: remoteDataSource,
  );

  group(
    'Get pokemon list',
    () {
      test(
        'Should return empty Pokemon list',
        () async {
          // Arrange
          when(
            () => remoteDataSource.getPokemonList(offset, itemsPerPage),
          ).thenAnswer(
            (_) async => const PokemonListingRemoteModel(
              pokemonList: [],
              totalAmount: 10,
            ),
          );

          // Act
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

          when(
            () => remoteDataSource.getPokemonList(offset, itemsPerPage),
          ).thenAnswer(
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
          const pokemonName = 'blastoise';
          const pokemonDetailRemoteModel = PokemonDetailRemoteModel(
            name: 'Blastoise',
          );

          when(
            () => cacheDataSource.getPokemonStatus(pokemonName),
          ).thenAnswer(
            (_) async => PokemonStatusCacheModel.free,
          );

          when(
            () => remoteDataSource.getPokemonDetail(pokemonName),
          ).thenAnswer(
            (_) async => pokemonDetailRemoteModel,
          );

          // Act
          final pokemonDetail = await repository.getPokemonDetail(pokemonName);

          // Assert
          expect(
            pokemonDetail.name,
            pokemonDetailRemoteModel.name,
          );
        },
      );
    },
  );

  group(
    'Catch and Release Pokemon',
    () {
      test(
        'Should catch pokemon',
        () async {
          // Arrange
          const pokemonName = 'blastoise';
          const pokemonDetailRemoteModel = PokemonDetailRemoteModel(
            name: 'Blastoise',
          );

          when(
            () => remoteDataSource.getPokemonDetail(pokemonName),
          ).thenAnswer(
            (_) async => pokemonDetailRemoteModel,
          );

          when(
            () => cacheDataSource.getPokemonStatus(pokemonName),
          ).thenAnswer(
            (_) async => PokemonStatusCacheModel.caught,
          );

          when(
            () => cacheDataSource.catchPokemon(pokemonName),
          ).thenAnswer(
            (_) async => {},
          );

          // Act
          await repository.catchPokemon(pokemonName);
          final pokemonDetail = await repository.getPokemonDetail(pokemonName);

          // Assert
          expect(
            pokemonDetail.status,
            PokemonStatus.caught,
          );
        },
      );

      test(
        'Should release pokemon',
        () async {
          // Arrange
          const pokemonName = 'blastoise';
          const pokemonDetailRemoteModel = PokemonDetailRemoteModel(
            name: 'Blastoise',
          );

          when(
            () => remoteDataSource.getPokemonDetail(pokemonName),
          ).thenAnswer(
            (_) async => pokemonDetailRemoteModel,
          );

          when(
            () => cacheDataSource.getPokemonStatus(pokemonName),
          ).thenAnswer(
            (_) async => PokemonStatusCacheModel.free,
          );

          when(
            () => cacheDataSource.catchPokemon(pokemonName),
          ).thenAnswer(
            (_) async => {},
          );

          // Act
          await repository.catchPokemon(pokemonName);
          final pokemonDetail = await repository.getPokemonDetail(pokemonName);

          // Assert
          expect(
            pokemonDetail.status,
            PokemonStatus.free,
          );
        },
      );
    },
  );

  group(
    'Get caught pokemon list',
    () {
      test(
        'Should return empty caught Pokemon list',
        () async {
          // Arrange
          when(
            () => cacheDataSource.getCaughtPokemonList(),
          ).thenAnswer(
            (_) async => [],
          );

          // Act
          final caughtPokemonList =
              await repository.getCaughtPokemonList();

          // Assert
          expect(caughtPokemonList.length, 0);
        },
      );

      test(
        'Should return Pokemon list with one Pokémon',
        () async {
          // Arrange
          const pokemonName = 'blastoise';

          when(
                () => cacheDataSource.getCaughtPokemonList(),
          ).thenAnswer(
                (_) async => [
              const PokemonCacheModel(
                name: pokemonName,
              ),
            ],
          );

          // Act
          final caughtPokemonList =
          await repository.getCaughtPokemonList();

          // Assert
          expect(caughtPokemonList.length, 1);
        },
      );
    },
  );
}
