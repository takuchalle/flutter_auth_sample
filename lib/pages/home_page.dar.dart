import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/authenticator.dart';

@immutable
class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Authenticator>(context, listen: false);
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: const Text('Logout'),
          onPressed: auth.signOut,
        ),
      ),
    );
  }
}
