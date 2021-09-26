import 'package:flutter/widgets.dart';

import 'bottom_navigation_tab.dart';
import 'material_bottom_navigation_scaffold.dart';

///Bottom Navigation adaptativa, se é iOS, adiciona Cupertino, CC, Material
class BottomNavigationScaffold extends StatefulWidget {
  const BottomNavigationScaffold(
    this.navigationBarItems, {
    Key? key,
  }) : super(key: key);

  /// Lista das tabs do app (List<AppFlow) da HomeScreen
  final List<BottomNavigationTab> navigationBarItems;

  @override
  _BottomNavigationScaffoldState createState() =>
      _BottomNavigationScaffoldState();
}

class _BottomNavigationScaffoldState extends State<BottomNavigationScaffold> {
  int _currentlySelectedIndex = 0;

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          final maybePop = await widget
              .navigationBarItems[_currentlySelectedIndex]
              .navigatorKey
              .currentState
              ?.maybePop();

          return !(maybePop ?? true);
        },
        child: MaterialBottomNavigationScaffold(
          widget.navigationBarItems,
          onTabSelected,
          _currentlySelectedIndex,
        ),
      );

  /// Seleção de tabs
  void onTabSelected(int newIndex) {
    if (_currentlySelectedIndex == newIndex) {
      ///Zera a pilha de telas caso a tab seja selecionada novamente
      widget.navigationBarItems[newIndex].navigatorKey.currentState!
          .popUntil((route) => route.isFirst);
    }

    ///Pelo que entendi, o Android precisa do setState para poder mudar de tab
    setState(() {
      _currentlySelectedIndex = newIndex;
    });
  }
}
