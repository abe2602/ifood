import 'package:dio/dio.dart';
import 'package:domain/repository/pokemon_repository.dart';
import 'package:domain/use_case/catch_pokemon_use_case.dart';
import 'package:domain/use_case/get_caught_pokemon_list_use_case.dart';
import 'package:domain/use_case/get_pokemon_detail_use_case.dart';
import 'package:domain/use_case/get_pokemon_list_use_case.dart';
import 'package:domain/use_case/release_pokemon_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ifood/data/local/cache/pokemon_cache_data_source/pokemon_cache_data_source.dart';
import 'package:ifood/data/local/cache/pokemon_cache_data_source/pokemon_cache_data_source_impl.dart';
import 'package:ifood/data/remote/pokemon_remote_data_source/pokemon_remote_data_source.dart';
import 'package:ifood/data/remote/pokemon_remote_data_source/pokemon_remote_data_source_impl.dart';
import 'package:ifood/data/repository/pokemon_repository_impl.dart';
import 'package:ifood/infrastructure/remote/challenge_dio.dart';
import 'package:ifood/infrastructure/routes/route_name_builder.dart';
import 'package:ifood/presentation/caught_pokemon/caught_pokemon_container.dart';
import 'package:ifood/presentation/main/main_screen.dart';
import 'package:ifood/presentation/pokemon_detail/pokemon_detail_container.dart';
import 'package:ifood/presentation/pokemon_list/pokemon_list_container.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:rxdart/rxdart.dart';

class ChallengeGeneralProvider extends StatelessWidget {
  const ChallengeGeneralProvider(
    this.builder, {
    Key? key,
  }) : super(key: key);

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          _buildDioProvider(),
          ..._buildStreamProviders(),
          ..._buildCacheDataSourceProviders(),
          ..._buildRemoteDataSourceProviders(),
          ..._buildRouteFactory(),
          ..._buildRepositoryProviders(),
          ..._buildUseCaseProviders(),
        ],
        child: builder(context),
      );

  SingleChildWidget _buildDioProvider() => Provider<Dio>(
        create: (_) {
          BaseOptions options = BaseOptions(
            baseUrl: 'https://pokeapi.co/api/v2/pokemon',
          );

          return ChallengeDio(options);
        },
      );

  List<SingleChildWidget> _buildRemoteDataSourceProviders() => [
        ProxyProvider<Dio, PokemonRemoteDataSource>(
          update: (_, dio, __) => PokemonRemoteDataSourceImpl(
            dio: dio,
          ),
        ),
      ];

  List<SingleChildWidget> _buildCacheDataSourceProviders() => [
        ProxyProvider<PublishSubject<void>, PokemonCacheDataSource>(
          update: (_, caughtPokemonDataObservable, __) =>
              PokemonCacheDataSourceImpl(
            caughtPokemonDataObservable: caughtPokemonDataObservable.sink,
          ),
        ),
      ];

  List<SingleChildWidget> _buildRouteFactory() => [
        Provider<RouteFactory>(
          create: (_) => (settings) {
            if (settings.name == RouteNameBuilder.getInitialRoute()) {
              return MaterialPageRoute(
                settings: settings,
                builder: (_) => MainScreen.create(),
              );
            }

            if (settings.name == RouteNameBuilder.getPokemonListRoute()) {
              return MaterialPageRoute(
                settings: settings,
                builder: (_) => PokemonListContainer.create(),
              );
            }

            if (settings.name == RouteNameBuilder.getPokemonDetailRoute()) {
              var args = settings.arguments as String;

              return MaterialPageRoute(
                settings: settings,
                builder: (_) => PokemonDetailContainer.create(args),
              );
            }

            if (settings.name == RouteNameBuilder.getCaughtPokemonListRoute()) {
              return MaterialPageRoute(
                settings: settings,
                builder: (_) => CaughtPokemonContainer.create(),
              );
            }

            return MaterialPageRoute(
              settings: settings,
              builder: (_) => Container(),
            );
          },
        ),
      ];

  List<SingleChildWidget> _buildRepositoryProviders() => [
        ProxyProvider2<PokemonRemoteDataSource, PokemonCacheDataSource,
            PokemonRepository>(
          update: (_, remoteDataSource, cacheDataSource, __) =>
              PokemonRepositoryImpl(
            remoteDataSource: remoteDataSource,
            cacheDataSource: cacheDataSource,
          ),
        ),
      ];

  List<SingleChildWidget> _buildUseCaseProviders() => [
        ProxyProvider<PokemonRepository, GetPokemonListUseCase>(
          update: (_, repository, __) => GetPokemonListUseCase(
            repository: repository,
          ),
        ),
        ProxyProvider<PokemonRepository, GetPokemonDetailUseCase>(
          update: (_, repository, __) => GetPokemonDetailUseCase(
            repository: repository,
          ),
        ),
        ProxyProvider<PokemonRepository, CatchPokemonUseCase>(
          update: (_, repository, __) => CatchPokemonUseCase(
            repository: repository,
          ),
        ),
        ProxyProvider<PokemonRepository, ReleasePokemonUseCase>(
          update: (_, repository, __) => ReleasePokemonUseCase(
            repository: repository,
          ),
        ),
        ProxyProvider<PokemonRepository, GetCaughtPokemonListUseCase>(
          update: (_, repository, __) => GetCaughtPokemonListUseCase(
            repository: repository,
          ),
        ),
      ];

  List<SingleChildWidget> _buildStreamProviders() => [
        Provider<PublishSubject<void>>(
          create: (_) => PublishSubject<void>(),
          dispose: (_, caughtPokemonDataObservable) =>
              caughtPokemonDataObservable.close(),
        ),
      ];
}
