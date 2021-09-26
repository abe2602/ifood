import 'package:domain/model/pokemon_detail.dart';
import 'package:domain/model/pokemon_detail_status.dart';
import 'package:domain/use_case/get_pokemon_detail_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ifood/data/repository/pokemon_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_pokemon_list_use_case_test.mocks.dart';

@GenerateMocks([PokemonRepositoryImpl])
void main() {
  test(
    'Should return Pokemon with name Blastoise',
    () async {
      // Arrange
      final mockPokemonRepository = MockPokemonRepositoryImpl();

      final getPokemonDetailUseCase = GetPokemonDetailUseCase(
        repository: mockPokemonRepository,
      );
      // Act
      when(mockPokemonRepository.getPokemonDetail('blastoise')).thenAnswer(
        (_) async => const PokemonDetail(
          name: 'blastoise',
          status: PokemonDetailStatus.free,
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
        PokemonDetailStatus.free,
      );
    },
  );
}
