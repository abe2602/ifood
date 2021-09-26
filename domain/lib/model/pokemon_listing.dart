import 'package:domain/model/pokemon.dart';

class PokemonListing {
  const PokemonListing({
    required this.pokemonList,
    required this.totalAmount,
  });

  final List<Pokemon> pokemonList;
  final int totalAmount;
}
