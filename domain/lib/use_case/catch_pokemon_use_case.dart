import 'package:domain/repository/pokemon_repository.dart';
import 'package:domain/use_case/use_case.dart';

class CatchPokemonUseCase extends UseCase<CatchPokemonUseCaseParams, void> {
  CatchPokemonUseCase({
    required this.repository,
  });

  final PokemonRepository repository;

  @override
  Future<void> getRawFuture(CatchPokemonUseCaseParams? params) {
    if (params != null) {
      return repository.catchPokemon(params.pokemonName);
    }

    return Future.value();
  }
}

class CatchPokemonUseCaseParams {
  const CatchPokemonUseCaseParams({
    required this.pokemonName,
  });

  final String pokemonName;
}
