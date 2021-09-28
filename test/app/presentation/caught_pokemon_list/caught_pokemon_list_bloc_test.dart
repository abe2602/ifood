import 'package:domain/model/pokemon.dart';
import 'package:domain/repository/pokemon_repository.dart';
import 'package:domain/use_case/get_caught_pokemon_list_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ifood/presentation/caught_pokemon/caught_pokemon_bloc.dart';
import 'package:ifood/presentation/caught_pokemon/model/caught_pokemon_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  final repository = MockPokemonRepository();

  final getCaughtPokemonListUseCase = GetCaughtPokemonListUseCase(
    repository: repository,
  );

  group(
    'Get pokemon list',
    () {
      test(
        'Should return empty caught Pokemon list',
        () async {
          // Arrange
          when(
            () => repository.getCaughtPokemonList(),
          ).thenAnswer(
            (_) async => [],
          );

          // Act
          final bloc = CaughtPokemonBloc(
            getCaughtPokemonListUseCase: getCaughtPokemonListUseCase,
            caughtPokemonDataObservable: PublishSubject(),
          );

          // Assert
          // Assert
          int stateCount = 0;
          bloc.onNewState.listen(
            expectAsync1<void, CaughtPokemonState>(
              (event) {
                if (stateCount == 0) {
                  expect(event is Loading, true);
                }

                if (stateCount == 1) {
                  expect(event is Success, true);
                  expect((event as Success).pokemonList, []);
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

      test(
        'Should return empty caught Pokemon list',
        () async {
          // Arrange
          when(
            () => repository.getCaughtPokemonList(),
          ).thenAnswer(
            (_) async => [
              const Pokemon(
                name: 'blastoise',
              ),
            ],
          );

          // Act
          final bloc = CaughtPokemonBloc(
            getCaughtPokemonListUseCase: getCaughtPokemonListUseCase,
            caughtPokemonDataObservable: PublishSubject(),
          );

          // Assert
          // Assert
          int stateCount = 0;
          bloc.onNewState.listen(
            expectAsync1<void, CaughtPokemonState>(
              (event) {
                if (stateCount == 0) {
                  expect(event is Loading, true);
                }

                if (stateCount == 1) {
                  expect(event is Success, true);
                  expect(
                    (event as Success).pokemonList.length,
                    1,
                  );
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
