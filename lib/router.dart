import 'package:flutter/material.dart';

import 'models/models.dart';
import 'pages/user_setting_page.dart';

typedef WidgetPageBuilder = Widget Function(
  BuildContext context,
  RouteSettings settings,
);

class Router {
  final _routes = <String, WidgetPageBuilder>{
    UserSettingPage.routeName: (context, settings) {
      final userDoc = settings.arguments as UserDoc;
      return UserSettingPage.create(userDoc);
    },
  };

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    var pageBuilder = _routes[settings.name];
    if (pageBuilder != null) {
      return MaterialPageRoute<void>(
        builder: (context) => pageBuilder(context, settings),
        settings: settings,
      );
    }

    assert(false, 'unexpected settings: $settings');
    return null;
  }
}
