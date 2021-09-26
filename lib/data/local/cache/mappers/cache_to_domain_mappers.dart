import 'package:ifood/data/local/cache/pokemon_cache_data_source/model/pokemon_status_cache_model.dart';
import 'package:domain/model/pokemon_status.dart';

extension PokemonStatusCacheToDomain on PokemonStatusCacheModel {
  PokemonStatus toDomain() {
    if (this == PokemonStatusCacheModel.free) {
      return PokemonStatus.free;
    } else {
      return PokemonStatus.caught;
    }
  }
}
