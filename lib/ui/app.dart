import 'package:app/blocs/blocs.dart';
import 'package:app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

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
      home: BlocProvider<NotificationBloc>(
        create: (_) => NotificationBloc(
          logger: injector<Logger>(),
          settingsRepository: injector<SettingsRepository>(),
        )..add(NotificationStarted()),
        child: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (_, __) => HomeScreen(),
        ),
      ),
    );
  }
}
