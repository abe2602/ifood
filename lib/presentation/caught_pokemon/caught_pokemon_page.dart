import 'package:domain/model/pokemon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifood/generated/l10n.dart';

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
            S.of(context).caughtPokemonListTitle,
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
