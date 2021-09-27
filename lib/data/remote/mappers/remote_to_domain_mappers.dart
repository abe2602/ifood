import 'package:domain/model/pokemon.dart';
import 'package:domain/model/pokemon_detail.dart';
import 'package:ifood/data/remote/pokemon_remote_data_source/model/pokemon_detail_remote_model.dart';
import 'package:domain/model/pokemon_status.dart';
import 'package:ifood/data/remote/pokemon_remote_data_source/model/pokemon_remote_model.dart';

extension PokemonDetailRemoteToDomain on PokemonDetailRemoteModel {
  PokemonDetail toDomain(PokemonStatus status) => PokemonDetail(
        name: name,
        status: status,
      );
}

extension PokemonListRemoteToDomain on List<PokemonRemoteModel> {
  List<Pokemon> toDomain() => map(
        (pokemon) => Pokemon(
          name: pokemon.name,
        ),
      ).toList();
}
