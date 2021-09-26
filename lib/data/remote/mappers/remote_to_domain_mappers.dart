import 'package:domain/model/pokemon_detail.dart';
import 'package:ifood/data/remote/pokemon_remote_data_source/model/pokemon_detail_remote_model.dart';
import 'package:domain/model/pokemon_status.dart';

extension PokemonDetailRemoteToDomain on PokemonDetailRemoteModel {
  PokemonDetail toDomain(PokemonStatus status) => PokemonDetail(
        name: name,
        status: status,
      );
}
