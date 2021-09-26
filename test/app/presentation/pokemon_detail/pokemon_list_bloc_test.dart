import 'package:domain/model/pokemon_listing.dart';
import 'package:domain/use_case/get_pokemon_list_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ifood/presentation/pokemon_list/model/pokemon_list_state.dart';
import 'package:ifood/presentation/pokemon_list/pokemon_list_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'pokemon_list_bloc_test.mocks.dart';

@GenerateMocks([GetPokemonListUseCase])
void main() {
  const offset = 0;
  const itemsPerPage = 1;

  test(
    'Should return empty Pokémon list',
    () async {
      // Arrange
      final mockGetPokemonListUseCase = MockGetPokemonListUseCase();

      // Act
      when(
        mockGetPokemonListUseCase(
          params: const GetPokemonListUseCaseParams(
            itemsPerPage: itemsPerPage,
            offset: offset,
          ),
        ),
      ).thenAnswer(
        (_) async => const PokemonListing(
          pokemonList: [],
          totalAmount: 10,
        ),
      );

      final bloc = PokemonListBloc(
        getPokemonListUseCase: mockGetPokemonListUseCase,
      )..requestNextPage(0);

      // Assert
      int state = 0;
      bloc.onNextPokemonListState.listen(
        expectAsync1<void, PokemonListingState>(
          (event) {
            if (state == 1) {

            }
            state++;
          },
          max: -1,
        ),
      );
    },
  );
}
