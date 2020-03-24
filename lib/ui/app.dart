import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'commons/commons.dart';
import 'features/features.dart';
import 'routes.dart';

class App extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: AppColors.transparent, statusBarIconBrightness: Brightness.dark),
    );

    return MaterialApp(
      title: 'Wash Hands Reminder',
      theme: theme,
      routes: routes,
      home: HomeScreen(),
    );
  }
}
