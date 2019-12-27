import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'auth/authenticator.dart';
import 'router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Authenticator(),
        ),
        Provider(create: (_) => Router())
      ],
      child: const App(),
    ),
  );
}
