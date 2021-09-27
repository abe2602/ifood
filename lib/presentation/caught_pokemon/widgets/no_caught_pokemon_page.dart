import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifood/generated/l10n.dart';

class NoCaughtPokemonPage extends StatelessWidget {
  const NoCaughtPokemonPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).caughtPokemonListTitle,
          ),
        ),
        body: Center(
          child: Text(
            S.of(context).noCaughtPokemonPageText,
          ),
        ),
      );
}
