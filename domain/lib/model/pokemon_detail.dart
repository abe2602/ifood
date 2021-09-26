import 'package:domain/model/pokemon_detail_status.dart';

class PokemonDetail {
  const PokemonDetail({
    required this.name,
    required this.status,
  });

  final String name;
  final PokemonDetailStatus status;
}
