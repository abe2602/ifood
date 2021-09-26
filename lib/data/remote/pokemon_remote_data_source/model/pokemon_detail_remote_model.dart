import 'package:json_annotation/json_annotation.dart';

part 'pokemon_detail_remote_model.g.dart';

@JsonSerializable()
class PokemonDetailRemoteModel {
  const PokemonDetailRemoteModel({
    required this.name,
  });

  factory PokemonDetailRemoteModel.fromJson(Map<String, dynamic> parsedJson) =>
      _$PokemonDetailRemoteModelFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$PokemonDetailRemoteModelToJson(this);

  @JsonKey(name: 'name')
  final String name;
}
