import 'package:flutter/material.dart';

@immutable
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('loading'),
      ),
    );
  }
}
