import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:subscription_holder/subscription_holder.dart';

import '../models/models.dart';

class Authenticator {
  Authenticator() {
    _accountController = StreamController<UserDoc>();
    _holder.add(
      _auth.onAuthStateChanged
          .distinct((a, b) => a?.uid == b?.uid)
          .listen((user) {
        if (user != null) {
          final userDoc = UserDoc.fromFirebaseUser(user);
          _accountController.add(userDoc);
        }
      }),
    );
  }

  Stream<UserDoc> get onAuthStateChanged =>
      _accountController.stream.distinct((a, b) => a?.id == b?.id);

  final _auth = FirebaseAuth.instance;
  StreamController<UserDoc> _accountController;
  SubscriptionHolder _holder = SubscriptionHolder();

  Future<void> signIn() async {
    final result = await _auth.signInAnonymously();
    final userDoc = UserDoc.fromFirebaseUser(result.user);
    final _userRef = UsersRef.ref().docRef(userDoc.id);
    await _userRef.set(userDoc.entity);
    _accountController.add(userDoc);
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _accountController.add(null);
  }

  void dispose() {
    _holder.dispose();
    _accountController.close();
  }
}
