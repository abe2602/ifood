import 'package:domain/use_case/get_pokemon_list_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:ifood/presentation/common/async_snapshot_response_view.dart';
import 'package:ifood/presentation/pokemon_list/model/pokemon_list_state.dart';
import 'package:ifood/presentation/pokemon_list/pokemon_list_bloc.dart';
import 'package:ifood/presentation/pokemon_list/pokemon_list_page.dart';
import 'package:provider/provider.dart';

class PokemonListContainer extends StatelessWidget {
  const PokemonListContainer({
    required this.bloc,
    Key? key,
  }) : super(key: key);

  static Widget create() =>
      ProxyProvider<GetPokemonListUseCase, PokemonListBloc>(
        update: (_, getPokemonListUseCase, bloc) =>
            bloc ??
            PokemonListBloc(
              getPokemonListUseCase: getPokemonListUseCase,
            ),
        dispose: (_, bloc) => bloc.dispose(),
        child: Consumer<PokemonListBloc>(
          builder: (_, bloc, __) => PokemonListContainer(
            bloc: bloc,
          ),
        ),
      );

  final PokemonListBloc bloc;

  @override
  Widget build(BuildContext context) => StreamBuilder<PokemonListState>(
        stream: bloc.onNewState,
        builder: (_, snapshot) =>
            AsyncSnapshotResponseView<Loading, Success, Error>(
          snapshot: snapshot,
          successWidgetBuilder: (success) => PokemonListPage.create(
            success.pokemonList,
          ),
          errorWidgetBuilder: (error) => Container(),
        ),
      );
}
