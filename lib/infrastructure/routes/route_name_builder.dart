class RouteNameBuilder {
  static const _initialRoute = '/';
  static const _pokemonListRoute = 'pokemon-list';
  static const _pokemonDetailRoute = 'pokemon-detail';
  static const _caughtPokemonListRoute = 'caught-pokemon-list';

  static String getInitialRoute() => _initialRoute;

  static String getPokemonListRoute() => _pokemonListRoute;

  static String getPokemonDetailRoute() => _pokemonDetailRoute;

  static String getCaughtPokemonListRoute() => _caughtPokemonListRoute;
}
