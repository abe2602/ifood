import 'package:dio/dio.dart';
import 'package:ifood/data/remote/pokemon_remote_data_source/model/pokemon_detail_remote_model.dart';
import 'package:ifood/data/remote/pokemon_remote_data_source/model/pokemon_listing_remote_model.dart';
import 'package:ifood/data/remote/pokemon_remote_data_source/pokemon_remote_data_source.dart';

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  const PokemonRemoteDataSourceImpl({
    required this.dio,
  });

  final Dio dio;

  @override
  Future<PokemonListingRemoteModel> getPokemonList(
      int offset, int itemsPerPage) async {
    try {
      final response = await dio.get(
        '?offset=$offset&limit=$itemsPerPage',
      );

      return PokemonListingRemoteModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<PokemonDetailRemoteModel> getPokemonDetail(String pokemonName)  async {
    try {
      final response = await dio.get(
        '/$pokemonName',
      );

      return PokemonDetailRemoteModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }
}
