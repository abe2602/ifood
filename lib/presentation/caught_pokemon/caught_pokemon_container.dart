import 'package:domain/use_case/get_caught_pokemon_list_use_case.dart';
import 'package:flutter/widgets.dart';
import 'package:ifood/presentation/caught_pokemon/caught_pokemon_bloc.dart';
import 'package:ifood/presentation/caught_pokemon/caught_pokemon_page.dart';
import 'package:ifood/presentation/caught_pokemon/model/caught_pokemon_state.dart';
import 'package:ifood/presentation/caught_pokemon/widgets/no_caught_pokemon_page.dart';
import 'package:ifood/presentation/common/async_snapshot_response_view.dart';
import 'package:ifood/presentation/common/generic_error_empty_state.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class CaughtPokemonContainer extends StatelessWidget {
  const CaughtPokemonContainer({
    required this.bloc,
    Key? key,
  }) : super(key: key);

  static Widget create() => ProxyProvider2<GetCaughtPokemonListUseCase,
          PublishSubject<void>, CaughtPokemonBloc>(
        update: (
          _,
          getCaughtPokemonListUseCase,
          caughtPokemonDataObservable,
          bloc,
        ) =>
            bloc ??
            CaughtPokemonBloc(
              getCaughtPokemonListUseCase: getCaughtPokemonListUseCase,
              caughtPokemonDataObservable: caughtPokemonDataObservable,
            ),
        dispose: (_, bloc) => bloc.dispose(),
        child: Consumer<CaughtPokemonBloc>(
          builder: (_, bloc, __) => CaughtPokemonContainer(
            bloc: bloc,
          ),
        ),
      );

  final CaughtPokemonBloc bloc;

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: bloc.onNewState,
        builder: (_, snapshot) =>
            AsyncSnapshotResponseView<Loading, Success, Error>(
          snapshot: snapshot,
          successWidgetBuilder: (success) {
            final caughtPokemonList = success.pokemonList;

            if (caughtPokemonList.isEmpty) {
              return const NoCaughtPokemonPage();
            } else {
              return CaughtPokemonPage(
                pokemonList: caughtPokemonList,
              );
            }
          },
          errorWidgetBuilder: (error) => GenericErrorEmptyState(
            onTryAgain: bloc.tryAgain,
            appBarTitle: '',
          ),
        ),
      );
}
