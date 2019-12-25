import 'package:flutter/material.dart';
import 'package:subscription_holder/subscription_holder.dart';

import 'user.dart';

class AccountNotifier extends ChangeNotifier {
  AccountNotifier({@required UserDoc account}) : _account = account {
    if (_account != null) {
      _holder.add(
        _ref.document().listen(
          (user) {
            _account = user;
            notifyListeners();
          },
        ),
      );
    }
  }

  UserDoc get account => _account;
  UserRef get _ref => UsersRef.ref().docRef(account.id);

  UserDoc _account;
  SubscriptionHolder _holder = SubscriptionHolder();

  Future<void> updateName(String name) async {
    final user = account.entity.copyWith(name: name);
    await _ref.merge(user);
  }

  @override
  void dispose() {
    _holder.dispose();
    super.dispose();
  }
}
