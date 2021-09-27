import 'package:flutter/material.dart';

extension DialogUtils on Widget {
  Future<T> showAsDialog<T>(
    BuildContext context, {
    bool isMaterialDismissible = true,
  }) async =>
      await showDialog(
        context: context,
        builder: (_) => this,
        barrierDismissible: isMaterialDismissible,
      );
}
