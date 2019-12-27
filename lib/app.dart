import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/root_page.dart';
import 'router.dart';

@immutable
class App extends StatelessWidget {
  const App({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RootPage(),
      onGenerateRoute: Provider.of<Router>(context).onGenerateRoute,
    );
  }
}
