import 'package:domain/model/pokemon.dart';
import 'package:domain/model/pokemon_detail.dart';
import 'package:domain/model/pokemon_listing.dart';

abstract class PokemonRepository {
  Future<PokemonListing> getPokemonList(int offset, int itemsPerPage);

  Future<PokemonDetail> getPokemonDetail(String pokemonName);

  Future<void> releasePokemon(String pokemonName);

  Future<void> catchPokemon(String pokemonName);

  Future<List<Pokemon>> getCaughtPokemonList();
}
