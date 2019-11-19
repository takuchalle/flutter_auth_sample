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
          Provider(
            builder: (context) => Account(
              Provider.of<Authenticator>(context, listen: false),
            ),
          ),
        ],
        child: const App(),
      ),
    );
