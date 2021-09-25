import 'package:domain/model/pokemon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PokemonListPage extends StatelessWidget {
  const PokemonListPage({
    required this.pokemonList,
    Key? key,
  }) : super(key: key);

  static Widget create(List<Pokemon> pokemonList) => PokemonListPage(
        pokemonList: pokemonList,
      );

  final List<Pokemon> pokemonList;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: ListView.builder(
            itemCount: pokemonList.length,
            itemBuilder: (_, index) => Text(
              pokemonList[index].name,
            ),
          ),
        ),
      );
}
