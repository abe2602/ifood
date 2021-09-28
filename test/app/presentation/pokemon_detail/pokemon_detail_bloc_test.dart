import 'package:domain/exceptions.dart';
import 'package:domain/model/pokemon_detail.dart';
import 'package:domain/model/pokemon_status.dart';
import 'package:domain/repository/pokemon_repository.dart';
import 'package:domain/use_case/catch_pokemon_use_case.dart';
import 'package:domain/use_case/get_pokemon_detail_use_case.dart';
import 'package:domain/use_case/release_pokemon_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ifood/presentation/pokemon_detail/model/pokemon_detail_state.dart';
import 'package:ifood/presentation/pokemon_detail/pokemon_detail_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  final repository = MockPokemonRepository();

  final getPokemonDetailUseCase = GetPokemonDetailUseCase(
    repository: repository,
  );

  final catchPokemonUseCase = CatchPokemonUseCase(
    repository: repository,
  );

  final releasePokemonUseCase = ReleasePokemonUseCase(
    repository: repository,
  );

  group(
    'Pokemon Detail state',
    () {
      test(
        'Should return successfully a Pokemon with name Blastoise',
        () async {
          // Arrange
          const pokemonName = 'blastoise';

          when(
            () => repository.getPokemonDetail(pokemonName),
          ).thenAnswer(
            (_) async => const PokemonDetail(
              name: pokemonName,
              status: PokemonStatus.free,
            ),
          );

          // Act
          final bloc = PokemonDetailBloc(
            pokemonName: pokemonName,
            getPokemonDetailUseCase: getPokemonDetailUseCase,
            catchPokemonUseCase: catchPokemonUseCase,
            releasePokemonUseCase: releasePokemonUseCase,
          );

          // Assert
          int state = 0;
          bloc.onNewState.listen(
            expectAsync1<void, PokemonDetailState>(
              (event) {
                if (state == 0) {
                  expect(event is Loading, true);
                }

                if (state == 1) {
                  expect(event is Success, true);
                  expect((event as Success).pokemonDetail.name, pokemonName);
                }

                if (state > 1) {
                  expect(false, true);
                }

                state++;
              },
              max: -1,
            ),
          );
        },
      );

      test(
        'Should return an Error',
        () async {
          // Arrange
          const pokemonName = 'blastoise';

          when(
            () => repository.getPokemonDetail(pokemonName),
          ).thenThrow(
            GenericException(),
          );

          // Act
          final bloc = PokemonDetailBloc(
            pokemonName: pokemonName,
            getPokemonDetailUseCase: getPokemonDetailUseCase,
            catchPokemonUseCase: catchPokemonUseCase,
            releasePokemonUseCase: releasePokemonUseCase,
          );

          // Assert
          int stateCount = 0;
          bloc.onNewState.listen(
            expectAsync1<void, PokemonDetailState>(
              (event) {
                if (stateCount == 0) {
                  expect(event is Loading, true);
                }

                if (stateCount == 1) {
                  expect(event is Error, true);
                }

                if (stateCount > 1) {
                  expect(false, true);
                }

                stateCount++;
              },
              max: -1,
            ),
          );
        },
      );
    },
  );
}
