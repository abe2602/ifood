import 'package:ifood/data/remote/pokemon_remote_data_source/model/pokemon_listing_remote_model.dart';

abstract class PokemonRemoteDataSource {
  Future<PokemonListingRemoteModel> getPokemonList(
      int offset, int itemsPerPage);
}
