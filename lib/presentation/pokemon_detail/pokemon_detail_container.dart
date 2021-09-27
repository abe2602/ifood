import 'package:domain/use_case/catch_pokemon_use_case.dart';
import 'package:domain/use_case/get_pokemon_detail_use_case.dart';
import 'package:domain/use_case/release_pokemon_use_case.dart';
import 'package:flutter/material.dart';
import 'package:ifood/presentation/common/action_handler.dart';
import 'package:ifood/presentation/common/alert_dialog/generic_error_alert_dialog.dart';
import 'package:ifood/presentation/common/async_snapshot_response_view.dart';
import 'package:ifood/presentation/common/generic_error_empty_state.dart';
import 'package:ifood/presentation/common/view_utils.dart';
import 'package:ifood/presentation/pokemon_detail/model/pokemon_detail_actions.dart';
import 'package:ifood/presentation/pokemon_detail/model/pokemon_detail_state.dart';
import 'package:ifood/presentation/pokemon_detail/pokemon_detail_bloc.dart';
import 'package:ifood/presentation/pokemon_detail/pokemon_detail_page.dart';
import 'package:provider/provider.dart';

class PokemonDetailContainer extends StatelessWidget {
  const PokemonDetailContainer({
    required this.bloc,
    Key? key,
  }) : super(key: key);

  static Widget create(String pokemonName) => ProxyProvider3<
          GetPokemonDetailUseCase,
          CatchPokemonUseCase,
          ReleasePokemonUseCase,
          PokemonDetailBloc>(
        update: (
          _,
          getPokemonDetailUseCase,
          catchPokemonUseCase,
          releasePokemonUseCase,
          bloc,
        ) =>
            bloc ??
            PokemonDetailBloc(
              pokemonName: pokemonName,
              getPokemonDetailUseCase: getPokemonDetailUseCase,
              catchPokemonUseCase: catchPokemonUseCase,
              releasePokemonUseCase: releasePokemonUseCase,
            ),
        dispose: (_, bloc) => bloc.dispose(),
        child: Consumer<PokemonDetailBloc>(
          builder: (_, bloc, __) => PokemonDetailContainer(
            bloc: bloc,
          ),
        ),
      );

  final PokemonDetailBloc bloc;

  @override
  Widget build(BuildContext context) => ActionHandler<PokemonDetailAction>(
        inputStream: bloc.onNewAction,
        resultStream: (action) {
          if (action is ChangePokemonStatusActionError) {
            GenericErrorAlertDialog().showAsDialog(context);
          }
        },
        child: Scaffold(
          body: StreamBuilder<PokemonDetailState>(
            stream: bloc.onNewState,
            builder: (_, snapshot) =>
                AsyncSnapshotResponseView<Loading, Success, Error>(
              snapshot: snapshot,
              successWidgetBuilder: (success) => PokemonDetailPage(
                pokemonDetail: success.pokemonDetail,
                onPokemonStatus: bloc.onPokemonStatus,
                onChangePokemonStatus: bloc.changePokemonStatus,
              ),
              errorWidgetBuilder: (_) => GenericErrorEmptyState(
                onTryAgain: bloc.tryAgain,
                appBarTitle: '',
              ),
            ),
          ),
        ),
      );
}
