import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/authenticator.dart';
import '../models/models.dart';

@immutable
class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Authenticator>(context);
    final account = Provider.of<AccountNotifier>(context).account;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('uid: ${account.uid}'),
            RaisedButton(
              child: const Text('Logout'),
              onPressed:
                  auth.status == AuthStatus.inProgress ? null : auth.signOut,
            ),
          ],
        ),
      ),
    );
  }
}
