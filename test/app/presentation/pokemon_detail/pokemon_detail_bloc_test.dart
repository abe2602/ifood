import 'package:domain/model/pokemon_detail.dart';
import 'package:domain/model/pokemon_status.dart';
import 'package:domain/use_case/get_pokemon_detail_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ifood/presentation/pokemon_detail/model/pokemon_detail_state.dart';
import 'package:ifood/presentation/pokemon_detail/pokemon_detail_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'pokemon_detail_bloc_test.mocks.dart';

@GenerateMocks([GetPokemonDetailUseCase])
void main() {
  test(
    'Should return Pokemon with name Blastoise',
    () async {
      // Arrange
      const pokemonName = 'blastoise';
      final mockGetPokemonDetailUseCase = MockGetPokemonDetailUseCase();

      // Act
      when(
        mockGetPokemonDetailUseCase(
          params: const GetPokemonDetailUseCaseParams(
            pokemonName: pokemonName,
          ),
        ),
      ).thenAnswer(
        (_) async => const PokemonDetail(
          name: pokemonName,
          status: PokemonStatus.free,
        ),
      );

      final bloc = PokemonDetailBloc(
        pokemonName: pokemonName,
        getPokemonDetailUseCase: mockGetPokemonDetailUseCase,
      );

      // Assert
      int state = 0;
      bloc.onNewState.listen(
        expectAsync1<void, PokemonDetailState>(
          (event) {
            if(state == 1) {
              expect(event is Success, true);
            }
            state++;
          },
          max: -1,
        ),
      );
    },
  );
}
