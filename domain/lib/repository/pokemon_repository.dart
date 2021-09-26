import 'package:domain/model/pokemon_listing.dart';

abstract class PokemonRepository {
  Future<PokemonListing> getPokemonList(int offset, int itemsPerPage);
}