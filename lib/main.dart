import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'auth/authenticator.dart';
import 'models/models.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Authenticator(),
        ),
        ChangeNotifierProxyProvider<Authenticator, AccountNotifier>(
          create: (context) => null,
          update: (context, auth, notify) =>
              AccountNotifier(account: auth.currentUser),
        ),
      ],
      child: const App(),
    ),
  );
}
