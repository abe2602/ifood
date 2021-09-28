import 'package:domain/model/pokemon_detail.dart';
import 'package:domain/model/pokemon_status.dart';
import 'package:domain/repository/pokemon_repository.dart';
import 'package:domain/use_case/get_pokemon_detail_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  test(
    'Should return Pokemon with name Blastoise',
    () async {
      // Arrange
      final mockRepository = MockPokemonRepository();

      final getPokemonDetailUseCase = GetPokemonDetailUseCase(
        repository: mockRepository,
      );

      // Act
      when(
        () => mockRepository.getPokemonDetail('blastoise'),
      ).thenAnswer(
        (_) async => const PokemonDetail(
          name: 'blastoise',
          status: PokemonStatus.free,
        ),
      );

      final pokemonDetail = await getPokemonDetailUseCase(
        params: const GetPokemonDetailUseCaseParams(
          pokemonName: 'blastoise',
        ),
      );

      // Assert
      expect(
        pokemonDetail.name,
        'blastoise',
      );

      expect(
        pokemonDetail.status,
        PokemonStatus.free,
      );
    },
  );
}
