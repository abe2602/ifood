import 'package:hive/hive.dart';

part 'pokemon_cache_model.g.dart';

@HiveType(typeId: 0)
class PokemonCacheModel {
  const PokemonCacheModel({
    required this.name,
  });

  @HiveField(0)
  final String name;
}
