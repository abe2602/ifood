import 'package:ifood/data/local/cache/pokemon_cache_data_source/model/pokemon_cache_model.dart';
import 'package:ifood/data/local/cache/pokemon_cache_data_source/model/pokemon_status_cache_model.dart';

abstract class PokemonCacheDataSource {
  Future<List<PokemonCacheModel>> getCaughtPokemonList();

  Future<PokemonStatusCacheModel> getPokemonStatus(String pokemonName);

  Future<void> catchPokemon(String pokemonName);

  Future<void> releasePokemon(String pokemonName);
}
