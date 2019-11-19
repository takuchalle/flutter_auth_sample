import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import '../auth/authenticator.dart';

class Account {
  Account(this.authenticator) {
    _subscription = authenticator.onAuthStateChanged.listen(
      (user) {
        _user = user;
      },
    );
  }

  String get uid => _user?.uid;

  final Authenticator authenticator;
  StreamSubscription _subscription;
  FirebaseUser _user;

  void dispose() {
    print('disposed');
    _subscription.cancel();
  }
}
