import 'package:domain/model/pokemon.dart';
import 'package:domain/repository/pokemon_repository.dart';
import 'package:domain/use_case/use_case.dart';

class GetPokemonListUseCase extends UseCase<void, List<Pokemon>> {
  GetPokemonListUseCase({
    required this.repository,
  });

  final PokemonRepository repository;

  @override
  Future<List<Pokemon>> getRawFuture(void params) =>
      repository.getPokemonList();
}
