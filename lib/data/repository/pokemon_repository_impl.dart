import 'package:domain/model/pokemon.dart';
import 'package:domain/repository/pokemon_repository.dart';
import 'package:ifood/data/remote/pokemon_remote_data_source/pokemon_remote_data_source.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  const PokemonRepositoryImpl({
    required this.remoteDataSource,
  });

  final PokemonRemoteDataSource remoteDataSource;

  @override
  Future<List<Pokemon>> getPokemonList() async {
    final remotePokemonList = await remoteDataSource.getPokemonList();

    return remotePokemonList.map(
      (pokemon) => Pokemon(
        name: pokemon.name,
      ),
    ).toList();
  }
}
