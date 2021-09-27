import 'package:domain/use_case/get_caught_pokemon_list_use_case.dart';
import 'package:ifood/presentation/caught_pokemon/model/caught_pokemon_state.dart';
import 'package:ifood/presentation/common/subscription_holder.dart';
import 'package:rxdart/rxdart.dart';

class CaughtPokemonBloc with SubscriptionHolder {
  CaughtPokemonBloc({
    required this.getCaughtPokemonListUseCase,
    required this.caughtPokemonDataObservable,
  }) {
    MergeStream([
      _getCaughtPokemonList(),
      caughtPokemonDataObservable.flatMap(
        (_) => _getCaughtPokemonList(),
      ),
    ]).listen(_onNewState.add).addTo(subscriptions);
  }

  final GetCaughtPokemonListUseCase getCaughtPokemonListUseCase;
  final PublishSubject<void> caughtPokemonDataObservable;

  // Subjects
  final _onNewState = BehaviorSubject<CaughtPokemonState>();

  // Streams
  Stream<CaughtPokemonState> get onNewState => _onNewState.stream;

  Stream<CaughtPokemonState> _getCaughtPokemonList() async* {
    yield Loading();

    try {
      final pokemonList = await getCaughtPokemonListUseCase();

      yield Success(
        pokemonList: pokemonList,
      );
    } catch (error) {
      yield Error();
    }
  }

  void dispose() {
    _onNewState.close();
    disposeAll();
  }
}
