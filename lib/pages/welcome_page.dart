import 'package:dot_pagination_swiper/dot_pagination_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:undraw/undraw.dart';

import '../models/models.dart';

@immutable
class WelcomePage extends StatelessWidget {
  const WelcomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final notify = Provider.of<AccountNotifier>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          DotPaginationSwiper(
            children: <Widget>[
              Center(
                child: UnDraw(
                  color: Colors.red,
                  illustration: UnDrawIllustration.modern_life,
                  placeholder: Text("Illustration is loading..."),
                  errorWidget:
                      Icon(Icons.error_outline, color: Colors.red, size: 50),
                ),
              ),
              Center(
                child: UnDraw(
                  color: Colors.red,
                  illustration: UnDrawIllustration.collaboration2,
                  placeholder: Text("Illustration is loading..."),
                  errorWidget:
                      Icon(Icons.error_outline, color: Colors.red, size: 50),
                ),
              ),
              Center(
                child: UnDraw(
                  color: Colors.red,
                  illustration: UnDrawIllustration.mobile_application,
                  placeholder: Text("Illustration is loading..."),
                  errorWidget:
                      Icon(Icons.error_outline, color: Colors.red, size: 50),
                ),
              ),
              Center(
                child: UnDraw(
                  color: Colors.red,
                  illustration: UnDrawIllustration.developer_activity,
                  placeholder: Text("Illustration is loading..."),
                  errorWidget:
                      Icon(Icons.error_outline, color: Colors.red, size: 50),
                ),
              ),
              Center(
                child: RaisedButton(
                  child: const Text('Start'),
                  onPressed: notify.markAsRead,
                ),
              )
            ],
          ),
          Align(
            child: FlatButton(
              child: Text('Skip'),
              onPressed: notify.markAsRead,
            ),
            alignment: Alignment.bottomLeft,
          ),
        ],
      ),
    );
  }
}
