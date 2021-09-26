// Mocks generated by Mockito 5.0.15 from annotations
// in ifood/test/app/data/repository/pokemon_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:dio/dio.dart' as _i2;
import 'package:ifood/data/remote/pokemon_remote_data_source/model/pokemon_detail_remote_model.dart'
    as _i4;
import 'package:ifood/data/remote/pokemon_remote_data_source/model/pokemon_listing_remote_model.dart'
    as _i3;
import 'package:ifood/data/remote/pokemon_remote_data_source/pokemon_remote_data_source_impl.dart'
    as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeDio_0 extends _i1.Fake implements _i2.Dio {}

class _FakePokemonListingRemoteModel_1 extends _i1.Fake
    implements _i3.PokemonListingRemoteModel {}

class _FakePokemonDetailRemoteModel_2 extends _i1.Fake
    implements _i4.PokemonDetailRemoteModel {}

/// A class which mocks [PokemonRemoteDataSourceImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockPokemonRemoteDataSourceImpl extends _i1.Mock
    implements _i5.PokemonRemoteDataSourceImpl {
  MockPokemonRemoteDataSourceImpl() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Dio get dio =>
      (super.noSuchMethod(Invocation.getter(#dio), returnValue: _FakeDio_0())
          as _i2.Dio);
  @override
  _i6.Future<_i3.PokemonListingRemoteModel> getPokemonList(
          int? offset, int? itemsPerPage) =>
      (super.noSuchMethod(
              Invocation.method(#getPokemonList, [offset, itemsPerPage]),
              returnValue: Future<_i3.PokemonListingRemoteModel>.value(
                  _FakePokemonListingRemoteModel_1()))
          as _i6.Future<_i3.PokemonListingRemoteModel>);
  @override
  _i6.Future<_i4.PokemonDetailRemoteModel> getPokemonDetail(
          String? pokemonName) =>
      (super.noSuchMethod(Invocation.method(#getPokemonDetail, [pokemonName]),
              returnValue: Future<_i4.PokemonDetailRemoteModel>.value(
                  _FakePokemonDetailRemoteModel_2()))
          as _i6.Future<_i4.PokemonDetailRemoteModel>);
  @override
  String toString() => super.toString();
}
