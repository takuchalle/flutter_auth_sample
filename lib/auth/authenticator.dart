import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/models.dart';

class Authenticator {
  Authenticator() {
    _accountController = StreamController<UserDoc>();
    checkCurrentUser();
  }

  Stream<UserDoc> get onAuthStateChanged =>
      _accountController.stream.distinct((a, b) => a?.id == b?.id);

  final _auth = FirebaseAuth.instance;
  StreamController<UserDoc> _accountController;

  Future<void> signIn() async {
    final result = await _auth.signInAnonymously();
    final userDoc = UserDoc.fromFirebaseUser(result.user);
    if (result.additionalUserInfo.isNewUser) {
      final userRef = UsersRef.ref().docRef(userDoc.id);
      final groupRef = GroupsRef.ref().docRef();
      final groupDoc = GroupDoc.create(groupRef.ref.documentID);
      final memberRef = MembersRef.ref(groupDoc.id).docRef(userDoc.id);
      {
        final batch = groupRef.bach();
        await userRef.set(userDoc.entity, batch: batch);
        await groupRef.set(groupDoc.entity, batch: batch);
        await memberRef.set(userDoc.entity, batch: batch);
        await batch.commit();
      }
    }
    _accountController.add(userDoc);
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _accountController.add(null);
  }

  Future<void> checkCurrentUser() async {
    final user = await _auth.currentUser();
    if (user != null) {
      final userDoc = UserDoc.fromFirebaseUser(user);
      _accountController.add(userDoc);
    }
  }

  void dispose() {
    _accountController.close();
  }
}
