import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Authenticator extends ChangeNotifier {
  Authenticator() {
    _userSubscription = onAuthStateChanged.listen((u) {
      _user = u;
      notifyListeners();
    });
  }

  final _auth = FirebaseAuth.instance;
  Stream<FirebaseUser> get onAuthStateChanged =>
      _auth.onAuthStateChanged.distinct((a, b) => a?.uid == b?.uid);

  AuthStatus get status => _status;
  FirebaseUser get user => _user;

  AuthStatus _status = AuthStatus.loggedOut;
  FirebaseUser _user;
  StreamSubscription _userSubscription;

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

  void dispose() async {
    await _userSubscription.cancel();
    super.dispose();
  }
}

enum AuthStatus {
  loggedOut,
  inProgress,
  loggedIn,
}
