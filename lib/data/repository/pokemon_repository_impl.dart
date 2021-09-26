import 'package:domain/model/pokemon.dart';
import 'package:domain/model/pokemon_detail.dart';
import 'package:domain/model/pokemon_listing.dart';
import 'package:domain/repository/pokemon_repository.dart';
import 'package:ifood/data/remote/pokemon_remote_data_source/pokemon_remote_data_source.dart';
import 'package:domain/model/pokemon_detail_status.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  const PokemonRepositoryImpl({
    required this.remoteDataSource,
  });

  final PokemonRemoteDataSource remoteDataSource;

  @override
  Future<PokemonListing> getPokemonList(int offset, int itemsPerPage) async {
    final remotePokemonListing =
        await remoteDataSource.getPokemonList(offset, itemsPerPage);

    return PokemonListing(
      pokemonList: remotePokemonListing.pokemonList
          .map(
            (pokemon) => Pokemon(
              name: pokemon.name,
            ),
          )
          .toList(),
      totalAmount: remotePokemonListing.totalAmount,
    );
  }

  @override
  Future<PokemonDetail> getPokemonDetail(String pokemonName) async {
    final pokemonDetail = await remoteDataSource.getPokemonDetail(pokemonName);

    return PokemonDetail(
      name: pokemonDetail.name,
      status: PokemonDetailStatus.free,
    );
  }
}
