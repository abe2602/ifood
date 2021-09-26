import 'package:ifood/data/remote/pokemon_remote_data_source/model/pokemon_remote_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_listing_remote_model.g.dart';

@JsonSerializable()
class PokemonListingRemoteModel {
  const PokemonListingRemoteModel({
    required this.pokemonList,
    required this.totalAmount,
  });

  factory PokemonListingRemoteModel.fromJson(Map<String, dynamic> parsedJson) =>
      _$PokemonListingRemoteModelFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$PokemonListingRemoteModelToJson(this);

  @JsonKey(name: 'results')
  final List<PokemonRemoteModel> pokemonList;

  @JsonKey(name: 'count')
  final int totalAmount;
}
