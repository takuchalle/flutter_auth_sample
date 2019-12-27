import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/authenticator.dart';
import '../models/models.dart';

class UserSettingPage extends StatelessWidget {
  static const routeName = '/userSetting';
  const UserSettingPage._({Key key}) : super(key: key);

  static Widget create(UserDoc userDoc) {
    return MultiProvider(
      providers: [
        Provider.value(value: userDoc),
      ],
      child: UserSettingPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Authenticator>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: RaisedButton(
          child: Text('logout'),
          onPressed: () async {
            await auth.signOut();
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
