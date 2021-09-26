import 'package:hive/hive.dart';
import 'package:ifood/data/local/cache/pokemon_cache_data_source/model/pokemon_cache_model.dart';
import 'package:ifood/data/local/cache/pokemon_cache_data_source/model/pokemon_status_cache_model.dart';
import 'package:ifood/data/local/cache/pokemon_cache_data_source/pokemon_cache_data_source.dart';

class PokemonCacheDataSourceImpl implements PokemonCacheDataSource {
  const PokemonCacheDataSourceImpl({
    required this.caughtPokemonDataObservable,
  });

  static const _caughtPokemonPageBoxKey = 'caughtPokemonPageBoxKey';

  final Sink<void> caughtPokemonDataObservable;

  Future<Box> _openCaughtPokemonBox() => Hive.openBox(_caughtPokemonPageBoxKey);

  @override
  Future<List<PokemonCacheModel>> getCaughtPokemonList() async {
    try {
      var box = await _openCaughtPokemonBox();
      final List<PokemonCacheModel>? caughtPokemonList =
          box.get(_caughtPokemonPageBoxKey)?.cast<PokemonCacheModel>();

      if (caughtPokemonList == null || caughtPokemonList.isEmpty) {
        return [];
      } else {
        return caughtPokemonList;
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> catchPokemon(String pokemonName) async {
    try {
      var box = await _openCaughtPokemonBox();
      final List<PokemonCacheModel> caughtPokemonList =
          (box.get(_caughtPokemonPageBoxKey)?.cast<PokemonCacheModel>() ?? [])
            ..add(
              PokemonCacheModel(
                name: pokemonName,
              ),
            );

      caughtPokemonDataObservable.add(null);
      return box.put(_caughtPokemonPageBoxKey, caughtPokemonList);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> releasePokemon(String pokemonName) async {
    try {
      var box = await _openCaughtPokemonBox();
      final List<PokemonCacheModel>? caughtPokemonList =
          box.get(_caughtPokemonPageBoxKey)?.cast<PokemonCacheModel>();

      if (caughtPokemonList == null || caughtPokemonList.isEmpty) {
        return Future.value();
      } else {
        final pokemon = caughtPokemonList
            .where(
              (pokemon) => pokemon.name == pokemonName,
            )
            .toList()
            .first;

        caughtPokemonList.remove(pokemon);

        caughtPokemonDataObservable.add(null);
        return box.put(_caughtPokemonPageBoxKey, caughtPokemonList);
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<PokemonStatusCacheModel> getPokemonStatus(String pokemonName) async {
    try {
      var box = await _openCaughtPokemonBox();
      final List<PokemonCacheModel>? caughtPokemonList =
          box.get(_caughtPokemonPageBoxKey)?.cast<PokemonCacheModel>();

      if (caughtPokemonList == null || caughtPokemonList.isEmpty) {
        return PokemonStatusCacheModel.free;
      } else {
        if (caughtPokemonList
            .map((pokemon) => pokemon.name)
            .contains(pokemonName)) {
          return PokemonStatusCacheModel.caught;
        } else {
          return PokemonStatusCacheModel.free;
        }
      }
    } catch (_) {
      rethrow;
    }
  }
}
