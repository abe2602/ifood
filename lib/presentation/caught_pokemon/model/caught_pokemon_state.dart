import 'package:domain/model/pokemon.dart';

abstract class CaughtPokemonState {}

class Success implements CaughtPokemonState {
  const Success({
    required this.pokemonList,
  });

  final List<Pokemon> pokemonList;
}

class Loading implements CaughtPokemonState {}

class Error implements CaughtPokemonState {}
