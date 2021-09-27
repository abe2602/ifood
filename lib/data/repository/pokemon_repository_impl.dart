import 'package:domain/model/pokemon.dart';
import 'package:domain/model/pokemon_detail.dart';
import 'package:domain/model/pokemon_listing.dart';
import 'package:domain/repository/pokemon_repository.dart';
import 'package:ifood/data/local/cache/pokemon_cache_data_source/pokemon_cache_data_source.dart';
import 'package:ifood/data/remote/pokemon_remote_data_source/pokemon_remote_data_source.dart';
import 'package:ifood/data/local/cache/mappers/cache_to_domain_mappers.dart';
import 'package:ifood/data/remote/mappers/remote_to_domain_mappers.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  const PokemonRepositoryImpl({
    required this.remoteDataSource,
    required this.cacheDataSource,
  });

  final PokemonRemoteDataSource remoteDataSource;
  final PokemonCacheDataSource cacheDataSource;

  @override
  Future<PokemonListing> getPokemonList(int offset, int itemsPerPage) async {
    final remotePokemonListing =
        await remoteDataSource.getPokemonList(offset, itemsPerPage);

    return PokemonListing(
      pokemonList: remotePokemonListing.pokemonList.toDomain(),
      totalAmount: remotePokemonListing.totalAmount,
    );
  }

  @override
  Future<PokemonDetail> getPokemonDetail(String pokemonName) async {
    final pokemonDetail = await remoteDataSource.getPokemonDetail(pokemonName);

    final status = await cacheDataSource.getPokemonStatus(pokemonName);

    return pokemonDetail.toDomain(
      status.toDomain(),
    );
  }

  @override
  Future<void> catchPokemon(String pokemonName) =>
      cacheDataSource.catchPokemon(pokemonName);

  @override
  Future<void> releasePokemon(String pokemonName) =>
      cacheDataSource.releasePokemon(pokemonName);

  @override
  Future<List<Pokemon>> getCaughtPokemonList() async {
    final cacheCaughtPokemonList = await cacheDataSource.getCaughtPokemonList();

    return cacheCaughtPokemonList.toDomain();
  }
}
