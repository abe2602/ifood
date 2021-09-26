import 'package:domain/repository/pokemon_repository.dart';
import 'package:domain/use_case/use_case.dart';

class ReleasePokemonUseCase extends UseCase<ReleasePokemonUseCaseParams, void> {
  ReleasePokemonUseCase({
    required this.repository,
  });

  final PokemonRepository repository;

  @override
  Future<void> getRawFuture(ReleasePokemonUseCaseParams? params) {
    if (params != null) {
      return repository.releasePokemon(params.pokemonName);
    }

    return Future.value();
  }
}

class ReleasePokemonUseCaseParams {
  const ReleasePokemonUseCaseParams({
    required this.pokemonName,
  });

  final String pokemonName;
}
