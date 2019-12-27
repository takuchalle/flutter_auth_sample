import 'package:flutter/material.dart';
import 'package:flutter_auth_sample/auth/authenticator.dart';
import 'package:flutter_auth_sample/models/account_notifier.dart';
import 'package:flutter_auth_sample/pages/home_page.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

@immutable
class RootPage extends StatelessWidget {
  const RootPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Authenticator>(context, listen: false);
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (context, snap) {
        if (snap.hasData) {
          return ChangeNotifierProvider(
            create: (_) => AccountNotifier(account: snap.data),
            child: HomePage.create(),
          );
        } else {
          return LoginPage.create();
        }
      },
    );
  }
}
