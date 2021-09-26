import 'package:domain/model/pokemon_detail.dart';

abstract class PokemonDetailState {}

class Success implements PokemonDetailState {
  const Success({
    required this.pokemonDetail,
  });

  final PokemonDetail pokemonDetail;
}

class Loading implements PokemonDetailState {}

class Error implements PokemonDetailState {}
