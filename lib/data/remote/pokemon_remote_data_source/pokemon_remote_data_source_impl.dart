import 'package:dio/dio.dart';
import 'package:ifood/data/remote/pokemon_remote_data_source/pokemon_remote_data_source.dart';
import 'package:ifood/data/remote/pokemon_remote_data_source/model/pokemon_remote_model.dart';

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  const PokemonRemoteDataSourceImpl({
    required this.dio,
  });

  final Dio dio;

  @override
  Future<List<PokemonRemoteModel>> getPokemonList() async {
    try {
      final response = await dio.get(
        '?offset=0&limit=150',
      );

      return (response.data['results'] as List)
          .map(
            (pokemon) => PokemonRemoteModel.fromJson(pokemon),
          )
          .toList();
    } catch (error) {
      rethrow;
    }
  }
}
