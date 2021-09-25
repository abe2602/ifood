import 'package:domain/model/pokemon.dart';

abstract class PokemonListState {}

class Success implements PokemonListState {
  const Success({
    required this.pokemonList,
  });

  final List<Pokemon> pokemonList;
}

class Error implements PokemonListState {}

class Loading implements PokemonListState {}
