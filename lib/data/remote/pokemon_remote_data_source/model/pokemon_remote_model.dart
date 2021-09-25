import 'package:json_annotation/json_annotation.dart';

part 'pokemon_remote_model.g.dart';

@JsonSerializable()
class PokemonRemoteModel {
  const PokemonRemoteModel({
    required this.name,
  });

  factory PokemonRemoteModel.fromJson(Map<String, dynamic> parsedJson) =>
      _$PokemonRemoteModelFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$PokemonRemoteModelToJson(this);

  @JsonKey(name: 'name')
  final String name;
}
