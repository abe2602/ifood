import 'package:flutter/material.dart';
import 'package:ifood/generated/l10n.dart';

class GenericErrorEmptyState extends StatelessWidget {
  const GenericErrorEmptyState({
    this.appBarTitle,
    this.onTryAgain,
    Key? key,
  }) : super(key: key);

  final String? appBarTitle;
  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: appBarTitle != null
            ? AppBar(
                title: Text(
                  appBarTitle!,
                ),
              )
            : null,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                S.of(context).genericErrorEmptyStateTitle,
              ),
            ),
            if (onTryAgain != null)
              TextButton(
                onPressed: onTryAgain,
                child: Text(
                  S.of(context).genericErrorEmptyStateButtonText,
                ),
              ),
          ],
        ),
      );
}
