// Mocks generated by Mockito 5.0.15 from annotations
// in ifood/test/domain/use_case/get_pokemon_list_use_case_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:domain/model/pokemon_detail.dart' as _i4;
import 'package:domain/model/pokemon_listing.dart' as _i3;
import 'package:ifood/data/remote/pokemon_remote_data_source/pokemon_remote_data_source.dart'
    as _i2;
import 'package:ifood/data/repository/pokemon_repository_impl.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakePokemonRemoteDataSource_0 extends _i1.Fake
    implements _i2.PokemonRemoteDataSource {}

class _FakePokemonListing_1 extends _i1.Fake implements _i3.PokemonListing {}

class _FakePokemonDetail_2 extends _i1.Fake implements _i4.PokemonDetail {}

/// A class which mocks [PokemonRepositoryImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockPokemonRepositoryImpl extends _i1.Mock
    implements _i5.PokemonRepositoryImpl {
  MockPokemonRepositoryImpl() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.PokemonRemoteDataSource get remoteDataSource =>
      (super.noSuchMethod(Invocation.getter(#remoteDataSource),
              returnValue: _FakePokemonRemoteDataSource_0())
          as _i2.PokemonRemoteDataSource);
  @override
  _i6.Future<_i3.PokemonListing> getPokemonList(
          int? offset, int? itemsPerPage) =>
      (super.noSuchMethod(
              Invocation.method(#getPokemonList, [offset, itemsPerPage]),
              returnValue:
                  Future<_i3.PokemonListing>.value(_FakePokemonListing_1()))
          as _i6.Future<_i3.PokemonListing>);
  @override
  _i6.Future<_i4.PokemonDetail> getPokemonDetail(String? pokemonName) =>
      (super.noSuchMethod(Invocation.method(#getPokemonDetail, [pokemonName]),
              returnValue:
                  Future<_i4.PokemonDetail>.value(_FakePokemonDetail_2()))
          as _i6.Future<_i4.PokemonDetail>);
  @override
  String toString() => super.toString();
}
