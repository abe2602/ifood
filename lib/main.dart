import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ifood/generated/l10n.dart';
import 'package:ifood/infrastructure/routes/route_name_builder.dart';
import 'package:ifood/presentation/common/challenge_general_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChallengeGeneralProvider(
      (_) => const ChallengeApp(),
    ),
  );
}

class ChallengeApp extends StatelessWidget {
  const ChallengeApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        onGenerateTitle: (context) => S.of(context).applicationName,
        initialRoute: RouteNameBuilder.getInitialRoute(),
        onGenerateRoute: Provider.of<RouteFactory>(
          context,
          listen: false,
        ),
      );
}
