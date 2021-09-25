import 'package:ifood/data/remote/pokemon_remote_data_source/model/pokemon_remote_model.dart';

abstract class PokemonRemoteDataSource {
  Future<List<PokemonRemoteModel>> getPokemonList();
}