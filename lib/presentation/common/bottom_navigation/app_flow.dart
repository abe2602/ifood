import 'package:flutter/widgets.dart';

/// Holds information about our app's flows.
class AppFlow {
  const AppFlow(
    this.title,
    this.mainColor,
    this.iconData,
    this.rootPage,
  );

  final String title;
  final Color mainColor;
  final IconData iconData;
  final Widget rootPage;
}
