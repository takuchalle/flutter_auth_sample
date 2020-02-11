import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'l10n.dart';
import 'pages/root_page.dart';
import 'router.dart';

@immutable
class App extends StatelessWidget {
  const App({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        const SampleLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja', ''),
      ],
      title: 'Flutter Demo',
      theme:
          ThemeData(primarySwatch: Colors.grey, brightness: Brightness.light),
      darkTheme:
          ThemeData(primarySwatch: Colors.grey, brightness: Brightness.dark),
      home: const RootPage(),
      onGenerateRoute: Provider.of<Router>(context).onGenerateRoute,
    );
  }
}
