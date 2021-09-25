import 'package:flutter/cupertino.dart';
import 'package:ifood/presentation/pokemon_list/pokemon_list_container.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  static Widget create() => const MainScreen();

  @override
  Widget build(BuildContext context) => PokemonListContainer.create();
}
