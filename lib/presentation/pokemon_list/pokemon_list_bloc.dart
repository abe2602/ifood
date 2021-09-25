import 'package:domain/use_case/get_pokemon_list_use_case.dart';
import 'package:ifood/presentation/common/subscription_holder.dart';
import 'package:ifood/presentation/pokemon_list/model/pokemon_list_state.dart';
import 'package:rxdart/rxdart.dart';

class PokemonListBloc with SubscriptionHolder {
  PokemonListBloc({
    required this.getPokemonListUseCase,
  }) {
    MergeStream([
      _getPokemonList(),
    ]).listen(_onNewStateSubject.add).addTo(subscriptions);
  }

  final GetPokemonListUseCase getPokemonListUseCase;

  // Subjects
  final _onNewStateSubject = BehaviorSubject<PokemonListState>();

  // Streams
  Stream<PokemonListState> get onNewState => _onNewStateSubject;

  Stream<PokemonListState> _getPokemonList() async* {
    yield Loading();

    try {
      final pokemonList = await getPokemonListUseCase();

      yield Success(
        pokemonList: pokemonList,
      );
    } catch (error) {
      yield Error();
    }
  }

  void dispose() {
    _onNewStateSubject.close();
    subscriptions.dispose();
  }
}
