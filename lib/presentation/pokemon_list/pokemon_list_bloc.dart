import 'package:domain/use_case/get_pokemon_list_use_case.dart';
import 'package:ifood/presentation/common/subscription_holder.dart';
import 'package:ifood/presentation/pokemon_list/model/pokemon_list_state.dart';
import 'package:rxdart/rxdart.dart';

class PokemonListBloc with SubscriptionHolder {
  PokemonListBloc({
    required this.getPokemonListUseCase,
  }) {
    _onNextPokemonListPageRequestSubject.stream
        .flatMap(_getPokemonList)
        .listen((state) {
      _onNextPokemonListStateSubject.add(state);
    }).addTo(subscriptions);

    // MergeStream([
    //   _getPokemonList(),
    // ]).listen(_onNewStateSubject.add).addTo(subscriptions);
  }

  final GetPokemonListUseCase getPokemonListUseCase;

  // Subjects
  final _onNewStateSubject = BehaviorSubject<PokemonListState>();

  final _onNextPokemonListStateSubject =
      BehaviorSubject<PokemonListingState>.seeded(
    const PokemonListingState(),
  );

  final _onNextPokemonListPageRequestSubject = PublishSubject<int>();

  // Sink
  Sink<int> get onNextPokemonListPageRequestSink =>
      _onNextPokemonListPageRequestSubject.sink;

  // Streams
  Stream<PokemonListState> get onNewState => _onNewStateSubject;

  Stream<PokemonListingState> get onNextPokemonListState =>
      _onNextPokemonListStateSubject.stream;

  bool _hasMoreItems = true;

  final _itemsPerPage = 100;

  Stream<PokemonListingState> _getPokemonList(int offset) async* {
    final lastListingState = _onNextPokemonListStateSubject.value;

    try {
      int nextOffset = 0;

      if(lastListingState.pokemonList != null) {
        nextOffset = offset + _itemsPerPage;
      }

      final pokemonListing = await getPokemonListUseCase(
        params: GetPokemonListUseCaseParams(
          offset: nextOffset,
          itemsPerPage: _itemsPerPage,
        ),
      );

      _hasMoreItems = pokemonListing.totalAmount > nextOffset;

      yield PokemonListingState(
        nextOffset: _hasMoreItems ? nextOffset : null,
        pokemonList: [
          ...lastListingState.pokemonList ?? [],
          ...pokemonListing.pokemonList
        ],
      );
    } catch (error) {
      print('error');
    }
  }

  void dispose() {
    _onNewStateSubject.close();
    _onNextPokemonListPageRequestSubject.close();
    _onNextPokemonListStateSubject.close();
    subscriptions.dispose();
  }
}