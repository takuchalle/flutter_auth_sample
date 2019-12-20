import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/authenticator.dart';

class _Model extends ChangeNotifier {
  _Model(Authenticator authenticator)
      : _auth = authenticator,
        _state = AuthState.logOut;

  void signIn() async {
    setState(AuthState.processing);
    await _auth.signIn();
    setState(AuthState.logIn);
  }

  void setState(AuthState state) {
    _state = state;
    notifyListeners();
  }

  AuthState get state => _state;

  final Authenticator _auth;
  AuthState _state;
}

enum AuthState { logOut, logIn, processing }

@immutable
class LoginPage extends StatelessWidget {
  const LoginPage._({Key key}) : super(key: key);

  static Widget create() {
    return ChangeNotifierProvider(
      create: (context) =>
          _Model(Provider.of<Authenticator>(context, listen: false)),
      child: LoginPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<_Model>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: RaisedButton(
          child: const Text('Login'),
          onPressed: model.state == AuthState.logOut ? model.signIn : null,
        ),
      ),
    );
  }
}
