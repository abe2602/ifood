import 'package:domain/model/pokemon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CaughtPokemonPage extends StatelessWidget {
  const CaughtPokemonPage({
    required this.pokemonList,
    Key? key,
  }) : super(key: key);

  final List<Pokemon> pokemonList;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'CAUGHT POKÉMON',
          ),
        ),
        body: ListView.builder(
          itemCount: pokemonList.length,
          itemBuilder: (_, index) => Padding(
            padding: const EdgeInsets.all(
              16,
            ),
            child: Center(
              child: Text(
                pokemonList[index].name,
              ),
            ),
          ),
        ),
      );
}
