import 'package:domain/model/pokemon.dart';

abstract class PokemonListState {}

class PokemonListingState implements PokemonListState {
  const PokemonListingState({
    this.pokemonList,
    this.nextOffset,
    this.error,
  });

  final List<Pokemon>? pokemonList;
  final int? nextOffset;
  final PokemonListingError? error;
}

class PokemonListingError implements PokemonListState {}

class Loading implements PokemonListState {}
