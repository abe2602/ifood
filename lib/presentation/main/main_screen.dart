import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifood/infrastructure/routes/route_name_builder.dart';
import 'package:ifood/presentation/common/bottom_navigation/bottom_navigation_scaffold.dart';
import 'package:ifood/presentation/common/bottom_navigation/bottom_navigation_tab.dart';
import 'package:ifood/presentation/pokemon_list/pokemon_list_container.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  static Widget create() => const MainScreen();

  @override
  Widget build(BuildContext context) => PokemonListContainer.create();

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<BottomNavigationTab>? _navigationBarItems;

  @override
  void didChangeDependencies() {
    _navigationBarItems ??= [
      BottomNavigationTab(
        bottomNavigationBarItem: const BottomNavigationBarItem(
          label: 'POKÉMON LIST',
          activeIcon: IconTheme(
            data: IconThemeData(
              color: Colors.black,
            ),
            child: Icon(
              Icons.home_filled,
            ),
          ),
          icon: Icon(
            Icons.home_outlined,
          ),
        ),
        navigatorKey: GlobalKey<NavigatorState>(),
        initialRouteName: RouteNameBuilder.getPokemonListRoute(),
      ),
      BottomNavigationTab(
        bottomNavigationBarItem: const BottomNavigationBarItem(
          label: 'CAUGHT POKÉMON',
          activeIcon: IconTheme(
            data: IconThemeData(
              color: Colors.black,
            ),
            child: Icon(
              Icons.favorite_outlined,
            ),
          ),
          icon: Icon(Icons.favorite_border),
        ),
        navigatorKey: GlobalKey<NavigatorState>(),
        initialRouteName: RouteNameBuilder.getPokemonListRoute(),
      ),
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => BottomNavigationScaffold(
        _navigationBarItems ?? [],
      );
}
