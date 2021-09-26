import 'package:domain/model/pokemon_detail.dart';
import 'package:flutter/material.dart';
import 'package:domain/model/pokemon_status.dart';
import 'package:ifood/generated/l10n.dart';

class PokemonDetailPage extends StatelessWidget {
  const PokemonDetailPage({
    required this.pokemonDetail,
    required this.onPokemonStatus,
    required this.onChangePokemonStatus,
    Key? key,
  }) : super(key: key);

  final PokemonDetail pokemonDetail;
  final Stream<PokemonStatus> onPokemonStatus;
  final ValueChanged<String> onChangePokemonStatus;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            pokemonDetail.name.toUpperCase(),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                pokemonDetail.name,
              ),
            ),
            StreamBuilder<PokemonStatus>(
              stream: onPokemonStatus,
              builder: (_, snapshot) => TextButton(
                onPressed: () => onChangePokemonStatus(pokemonDetail.name),
                child: Text(
                  snapshot.data == PokemonStatus.caught
                      ? S.of(context).pokemonDetailPageReleaseButtonStatusText
                      : S.of(context).pokemonDetailPageCatchButtonStatusText,
                ),
              ),
            ),
          ],
        ),
      );
}
