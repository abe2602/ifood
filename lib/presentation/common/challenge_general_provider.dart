
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ifood/infrastructure/remote/challenge_dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ChallengeGeneralProvider extends StatelessWidget {
  const ChallengeGeneralProvider(
    this.builder, {
    Key? key,
  }) : super(key: key);

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ..._buildRemoteDataSourceProviders(),
          ..._buildRouteFactory(),
        ],
        child: builder(context),
      );

  List<SingleChildWidget> _buildRemoteDataSourceProviders() => [
        Provider<Dio>(
          create: (_) {
            BaseOptions options = BaseOptions(
              baseUrl: 'https://pokeapi.co/api/v2/pokemon',
            );

            return ChallengeDio(options);
          },
        ),
      ];

  List<SingleChildWidget> _buildRouteFactory() => [
        Provider<RouteFactory>(
          create: (_) => (settings) {
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => Container(),
            );
          },
        ),
      ];
}
