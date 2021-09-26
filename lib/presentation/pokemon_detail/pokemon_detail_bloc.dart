import 'package:domain/model/pokemon_detail.dart';
import 'package:domain/model/pokemon_detail_status.dart';
import 'package:domain/use_case/get_pokemon_detail_use_case.dart';
import 'package:ifood/presentation/pokemon_detail/model/pokemon_detail_actions.dart';
import 'package:ifood/presentation/pokemon_detail/model/pokemon_detail_state.dart';
import 'package:rxdart/rxdart.dart';

class PokemonDetailBloc {
  PokemonDetailBloc({
    required this.pokemonName,
    required this.getPokemonDetailUseCase,
  }) {
    MergeStream([
      _getPokemonDetail(),
      _onChangePokemonStatus.flatMap(_changePokemonStatus),
    ]).listen(_onNewState.add);
  }

  final String pokemonName;
  final GetPokemonDetailUseCase getPokemonDetailUseCase;

  // Subjects
  final _onNewState = BehaviorSubject<PokemonDetailState>();

  final _onNewAction = BehaviorSubject<PokemonDetailAction>();

  final _onPokemonStatus = BehaviorSubject<PokemonDetailStatus>();

  final _onChangePokemonStatus = PublishSubject<String>();

  // Streams
  Stream<PokemonDetailState> get onNewState => _onNewState.stream;

  Stream<PokemonDetailAction> get onNewAction => _onNewAction.stream;

  Stream<PokemonDetailStatus> get onPokemonStatus => _onPokemonStatus.stream;

  Stream<PokemonDetailState> _getPokemonDetail() async* {
    yield Loading();

    try {
      final pokemonDetail = await getPokemonDetailUseCase(
        params: GetPokemonDetailUseCaseParams(
          pokemonName: pokemonName,
        ),
      );

      yield Success(
        pokemonDetail: pokemonDetail,
      );
    } catch (error) {
      yield Error();
    }
  }

  Stream<PokemonDetailState> _changePokemonStatus(String pokemonName) async* {
    final pokemonDetail = (_onNewState.value as Success).pokemonDetail;
    PokemonDetailStatus newStatus = pokemonDetail.status;

    yield Loading();

    try {
      if (pokemonDetail.status == PokemonDetailStatus.free) {
        newStatus = PokemonDetailStatus.caught;
      } else {
        newStatus = PokemonDetailStatus.free;
      }

      _onPokemonStatus.add(newStatus);
    } catch (error) {
      _onNewAction.add(
        ChangePokemonStatusActionError(),
      );
    } finally {
      yield Success(
        pokemonDetail: PokemonDetail(
          name: pokemonDetail.name,
          status: newStatus,
        ),
      );
    }
  }

  void changePokemonStatus(String pokemonName) {
    _onChangePokemonStatus.add(pokemonName);
  }

  void dispose() {
    _onNewAction.close();
    _onChangePokemonStatus.close();
    _onPokemonStatus.close();
    _onNewState.close();
  }
}
