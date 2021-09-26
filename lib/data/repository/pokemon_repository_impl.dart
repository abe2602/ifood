import 'package:domain/model/pokemon.dart';
import 'package:domain/model/pokemon_listing.dart';
import 'package:domain/repository/pokemon_repository.dart';
import 'package:ifood/data/remote/pokemon_remote_data_source/pokemon_remote_data_source.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  const PokemonRepositoryImpl({
    required this.remoteDataSource,
  });

  final PokemonRemoteDataSource remoteDataSource;

  @override
  Future<PokemonListing> getPokemonList(int offset, int itemsPerPage) async {
    try {
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
    } catch (error) {
      rethrow;
    }
  }
}
