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
        Provider(
          create: (_) => Authenticator(),
        ),
        ChangeNotifierProvider(
          create: (context) => AccountNotifier(
              authenticator: Provider.of(context, listen: false)),
        ),
      ],
      child: const App(),
    ),
  );
}
