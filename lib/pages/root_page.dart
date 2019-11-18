import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/authenticator.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'splash_screen.dart';

@immutable
class RootPage extends StatelessWidget {
  const RootPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Authenticator>(context, listen: false);

    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }

        if (snapshot.hasData) {
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
