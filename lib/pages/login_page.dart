import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/authenticator.dart';

@immutable
class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Authenticator>(context);
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: const Text('Login'),
          onPressed: auth.status == AuthStatus.inProgress ? null : auth.signIn,
        ),
      ),
    );
  }
}
