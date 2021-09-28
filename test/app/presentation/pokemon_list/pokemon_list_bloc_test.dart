import 'package:domain/model/pokemon_listing.dart';
import 'package:domain/repository/pokemon_repository.dart';
import 'package:domain/use_case/get_pokemon_list_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ifood/presentation/pokemon_list/model/pokemon_list_state.dart';
import 'package:ifood/presentation/pokemon_list/pokemon_list_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  const offset = 0;
  const itemsPerPage = 1;

  final repository = MockPokemonRepository();
  final getPokemonListUseCase = GetPokemonListUseCase(
    repository: repository,
  );

  test(
    'Should return empty Pokémon list',
    () async {
      // Arrange
      when(
        () => repository.getPokemonList(offset, itemsPerPage),
      ).thenAnswer(
        (_) async => const PokemonListing(
          pokemonList: [],
          totalAmount: 10,
        ),
      );

      // Act
      final bloc = PokemonListBloc(
        getPokemonListUseCase: getPokemonListUseCase,
      );

      // Assert
      bloc.onNextPokemonListState.listen(
        expectAsync1<void, PokemonListingState>(
          (event) {
            expect(event is PokemonListState, true);
          },
          max: -1,
        ),
      );
    },
  );
}
