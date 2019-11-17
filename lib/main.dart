import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'auth/authenticator.dart';
import 'models/models.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<Authenticator>(
            builder: (_) => Authenticator(),
          ),
          ProxyProvider<Authenticator, Account>(
            builder: (_, auth, old) => Account(auth.user?.uid, old),
            dispose: (_, account) => account?.dispose(),
            updateShouldNotify: (a, b) => a?.uid != b?.uid,
          ),
        ],
        child: const App(),
      ),
    );
