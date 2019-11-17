import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Authenticator extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  Stream<FirebaseUser> get onAuthStateChanged =>
      _auth.onAuthStateChanged.distinct((a, b) => a?.uid == b?.uid);

  AuthStatus get status => _status;

  AuthStatus _status = AuthStatus.loggedOut;

  Future<void> signIn() async {
    _updateStatus(AuthStatus.inProgress);
    await _auth.signInAnonymously();
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
}

enum AuthStatus {
  loggedOut,
  inProgress,
  loggedIn,
}
