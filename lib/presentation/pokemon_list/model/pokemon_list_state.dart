import 'package:domain/model/pokemon.dart';

abstract class PokemonListState {}

class Success implements PokemonListState {
  const Success({
    required this.pokemonList,
  });

  final List<Pokemon> pokemonList;
}

class PokemonListingState implements PokemonListState {
  const PokemonListingState({
    this.pokemonList,
    this.nextOffset,
  });

  final List<Pokemon>? pokemonList;
  final int? nextOffset;
}

class Error implements PokemonListState {}

class Loading implements PokemonListState {}
