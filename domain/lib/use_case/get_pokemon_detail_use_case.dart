import 'package:domain/model/pokemon_detail.dart';
import 'package:domain/repository/pokemon_repository.dart';
import 'package:domain/use_case/use_case.dart';

class GetPokemonDetailUseCase
    extends UseCase<GetPokemonDetailUseCaseParams, PokemonDetail> {
  GetPokemonDetailUseCase({
    required this.repository,
  });

  final PokemonRepository repository;

  @override
  Future<PokemonDetail> getRawFuture(
      GetPokemonDetailUseCaseParams? params) async {
    if (params != null) {
      return repository.getPokemonDetail(
        params.pokemonName,
      );
    }

    return Future.value();
  }
}

class GetPokemonDetailUseCaseParams {
  const GetPokemonDetailUseCaseParams({
    required this.pokemonName,
  });

  final String pokemonName;
}
