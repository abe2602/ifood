import 'package:domain/model/pokemon.dart';
import 'package:domain/model/pokemon_status.dart';
import 'package:ifood/data/local/cache/pokemon_cache_data_source/model/pokemon_cache_model.dart';
import 'package:ifood/data/local/cache/pokemon_cache_data_source/model/pokemon_status_cache_model.dart';

extension PokemonStatusCacheToDomain on PokemonStatusCacheModel {
  PokemonStatus toDomain() {
    if (this == PokemonStatusCacheModel.free) {
      return PokemonStatus.free;
    } else {
      return PokemonStatus.caught;
    }
  }
}

extension PokemonListCacheToDomain on List<PokemonCacheModel> {
  List<Pokemon> toDomain() => map(
        (pokemon) => Pokemon(
          name: pokemon.name,
        ),
      ).toList();
}
