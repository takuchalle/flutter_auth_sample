import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/authenticator.dart';

@immutable
class RootPage extends StatelessWidget {
  const RootPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Authenticator>(context, listen: false);

    return Scaffold();
  }
}
