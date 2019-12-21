import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/authenticator.dart';
import '../models/models.dart';

class _ViewModel extends ChangeNotifier {
  _ViewModel({@required this.notify, @required this.auth});
  final AccountNotifier notify;
  final Authenticator auth;

  UserDoc get account => notify.account;
}

@immutable
class HomePage extends StatelessWidget {
  const HomePage._({Key key}) : super(key: key);

  static Widget create(AccountNotifier notify) {
    return ChangeNotifierProvider(
      create: (context) => _ViewModel(
        notify: notify,
        auth: Provider.of<Authenticator>(context, listen: false),
      ),
      child: const HomePage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<_ViewModel>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('uid: ${model.account.id}'),
            RaisedButton(
              child: const Text('Logout'),
              onPressed: model.auth.signOut,
            ),
          ],
        ),
      ),
    );
  }
}
