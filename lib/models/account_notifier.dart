import 'package:flutter/material.dart';
import 'package:flutter_auth_sample/auth/authenticator.dart';

import 'user.dart';

class AccountNotifier extends ChangeNotifier {
  AccountNotifier({@required this.authenticator})
      : assert(authenticator != null) {
    authenticator.onAuthStateChanged.listen((account) {
      _account = account;
      notifyListeners();
    });
  }

  UserDoc get account => _account;

  UserDoc _account;
  final Authenticator authenticator;
}
