import 'package:flutter/material.dart';
import 'package:flutter_auth_sample/auth/authenticator.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class _ViewModel {
  _ViewModel({this.notify});
  final AccountNotifier notify;

  User get user => notify.account.entity;
}

class UserSettingList extends StatelessWidget {
  const UserSettingList({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<_ViewModel>(context, listen: false);
    final auth = Provider.of<Authenticator>(context, listen: false);
    return Column(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(model.user.profileURL),
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text(model.user.name),
          trailing: Icon(Icons.edit),
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('logout'),
          onTap: () async {
            await auth.signOut();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class UserSettingPage extends StatelessWidget {
  static const routeName = '/userSetting';
  const UserSettingPage._({Key key}) : super(key: key);

  static Widget create(UserDoc userDoc) {
    return Provider(
      create: (_) => _ViewModel(notify: AccountNotifier(account: userDoc)),
      child: const UserSettingPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: UserSettingList(),
    );
  }
}
