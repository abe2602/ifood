import 'package:domain/model/pokemon.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getPokemonList();
}