import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'auth/authenticator.dart';
import 'models/models.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            builder: (_) => Authenticator(),
          ),
          ChangeNotifierProvider(
            builder: (context) => AccountNotifier(
              authenticator: Provider.of(context, listen: false),
            ),
          ),
        ],
        child: const App(),
      ),
    );
