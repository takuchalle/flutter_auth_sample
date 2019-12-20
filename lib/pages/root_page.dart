import 'package:flutter/material.dart';
import 'package:flutter_auth_sample/pages/home_page.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import 'login_page.dart';

@immutable
class RootPage extends StatelessWidget {
  const RootPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final notify = Provider.of<AccountNotifier>(context);
    if (notify.account != null) {
      return const HomePage();
    } else {
      return LoginPage.create();
    }
  }
}
