import 'package:domain/model/pokemon_listing.dart';
import 'package:domain/repository/pokemon_repository.dart';
import 'package:domain/use_case/use_case.dart';

class GetPokemonListUseCase
    extends UseCase<GetPokemonListUseCaseParams, PokemonListing> {
  GetPokemonListUseCase({
    required this.repository,
  });

  final PokemonRepository repository;

  @override
  Future<PokemonListing> getRawFuture(
      GetPokemonListUseCaseParams? params) async {
    if (params != null) {
      return repository.getPokemonList(
        params.offset,
        params.itemsPerPage,
      );
    }

    return Future.value();
  }
}

class GetPokemonListUseCaseParams {
  const GetPokemonListUseCaseParams({
    required this.offset,
    required this.itemsPerPage,
  });

  final int offset;
  final int itemsPerPage;
}
