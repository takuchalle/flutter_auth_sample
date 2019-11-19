import 'package:flutter/material.dart';
import 'package:flutter_auth_sample/auth/authenticator.dart';

import 'account.dart';

class AccountNotifier extends ChangeNotifier {
  AccountNotifier({@required this.authenticator})
      : assert(authenticator != null) {
    authenticator.onAuthStateChanged.listen((account) {
      _account = account;
      notifyListeners();
    });
  }

  Account get account => _account;

  Account _account;
  final Authenticator authenticator;
}
