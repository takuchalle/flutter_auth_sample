import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class Authenticator {
  Future<void> signIn() async {
    await _auth.signInAnonymously();
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  final _auth = FirebaseAuth.instance;
  Stream<FirebaseUser> get onAuthStateChanged => _auth.onAuthStateChanged;
}
