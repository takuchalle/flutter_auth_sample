import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/authenticator.dart';
import '../models/models.dart';

class _ViewModel extends ChangeNotifier {
  _ViewModel({@required this.notify, @required this.auth});
  final AccountNotifier notify;
  final Authenticator auth;

  UserDoc _account;

  UserDoc get account => _account;

  @override
  void dispose() {
    super.dispose();
  }
}

class ChangeNameForm extends StatefulWidget {
  const ChangeNameForm(this.user, {Key key}) : super(key: key);

  final UserDoc user;
  @override
  _ChangeNameFormState createState() => _ChangeNameFormState();
}

class _ChangeNameFormState extends State<ChangeNameForm> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.user.entity.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notify = Provider.of<AccountNotifier>(context);
    return Column(
      children: <Widget>[
        TextField(
          controller: _controller,
        ),
        RaisedButton(
          child: Text('update'),
          onPressed: () async {
            await notify.updateName(_controller.text);
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
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
    final notify = Provider.of<AccountNotifier>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('uid: ${notify.account.id}'),
            Text('name: ${notify.account.entity.name}'),
            RaisedButton(
              child: const Text('Logout'),
              onPressed: model.auth.signOut,
            ),
            ChangeNameForm(notify.account),
          ],
        ),
      ),
    );
  }
}
