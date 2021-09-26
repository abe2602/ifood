import 'package:domain/model/pokemon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifood/presentation/common/subscription_holder.dart';
import 'package:ifood/presentation/pokemon_list/model/pokemon_list_state.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({
    required this.onNextPokemonListState,
    required this.onNextPokemonListPageRequestSink,
    required this.onTryAgain,
    Key? key,
  }) : super(key: key);

  static Widget create(
          Stream<PokemonListingState> onNextPokemonListState,
          Sink<int> onNextPokemonListPageRequestSink,
          VoidCallback onTryAgain) =>
      PokemonListPage(
        onNextPokemonListState: onNextPokemonListState,
        onNextPokemonListPageRequestSink: onNextPokemonListPageRequestSink,
        onTryAgain: onTryAgain,
      );

  final Stream<PokemonListingState> onNextPokemonListState;
  final Sink<int> onNextPokemonListPageRequestSink;
  final VoidCallback onTryAgain;

  @override
  State<StatefulWidget> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage>
    with SubscriptionHolder {
  final PagingController<int, Pokemon> _pokemonListController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pokemonListController
        .addPageRequestListener(widget.onNextPokemonListPageRequestSink.add);

    widget.onNextPokemonListState.listen((listingState) {
      _pokemonListController.value = PagingState(
        nextPageKey: listingState.nextOffset,
        error: listingState.error,
        itemList: listingState.pokemonList,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: PagedListView<int, Pokemon>(
            pagingController: _pokemonListController,
            builderDelegate: PagedChildBuilderDelegate(
              itemBuilder: (_, pokemon, __) => Text(
                pokemon.name,
              ),
              firstPageErrorIndicatorBuilder: (_) => TextButton(
                onPressed: widget.onTryAgain,
                child: const Center(
                  child: Text(
                    'Algo deu errado, tente novament',
                  ),
                ),
              ),
              newPageErrorIndicatorBuilder: (_) => TextButton(
                onPressed: widget.onTryAgain,
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(
                      8,
                    ),
                    child: Icon(
                      Icons.refresh_outlined,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  @override
  void dispose() {
    _pokemonListController.dispose();
    super.dispose();
  }
}
