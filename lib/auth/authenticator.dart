import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/models.dart';

class Authenticator extends ChangeNotifier {
  Authenticator() {
    _accountController = StreamController<Account>();
    _auth.onAuthStateChanged.distinct((a, b) => a?.uid == b?.uid).listen(
          (user) => _accountController.sink
              .add(user != null ? Account(user.uid) : null),
        );
  }

  Stream<Account> get onAuthStateChanged => _accountController.stream;

  AuthStatus get status => _status;

  final _auth = FirebaseAuth.instance;
  AuthStatus _status = AuthStatus.loggedOut;
  StreamController<Account> _accountController;

  Future<void> signIn() async {
    _updateStatus(AuthStatus.inProgress);
    final result = await _auth.signInAnonymously();
    final user = result.user;
    _accountController.sink
        .add(Account(user.uid, isFirst: result.additionalUserInfo.isNewUser));
    _updateStatus(AuthStatus.loggedIn);
  }

  Future<void> signOut() async {
    _updateStatus(AuthStatus.inProgress);
    await _auth.signOut();
    _updateStatus(AuthStatus.loggedOut);
  }

  void _updateStatus(AuthStatus status) {
    _status = status;
    notifyListeners();
  }

  @override
  void dispose() {
    _accountController.close();
    super.dispose();
  }
}

enum AuthStatus {
  loggedOut,
  inProgress,
  loggedIn,
}
