import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ifood/data/remote/pokemon_remote_data_source/pokemon_remote_data_source_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'pokemon_remote_data_source_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  group(
    'Get pokemon list',
    () {
      final mockDio = MockDio();
      final remoteDataSource = PokemonRemoteDataSourceImpl(dio: mockDio);

      test(
        'Empty Pokemon list should be returned',
        () async {
          // Arrange
          final responsePayload = jsonEncode({'results': '[]'});

          // Act
          when(mockDio.get('?offset=0&limit=150')).thenAnswer(
            (_) async => Response(
              data: responsePayload,
              requestOptions: RequestOptions(
                path: '',
              ),
            ),
          );

          final pokemonList = await remoteDataSource.getPokemonList();

          // Assert
          expect(pokemonList, []);
        },
      );
    },
  );
}
