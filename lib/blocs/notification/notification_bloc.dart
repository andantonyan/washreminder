import 'package:app/core/core.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart' hide RepeatInterval;
import 'package:meta/meta.dart';

import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  // TODO: move to service
  static final _initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  static final _initializationSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    onDidReceiveLocalNotification: (int id, String title, String body, String payload) async {},
  );
  static final _initializationSettings = InitializationSettings(
    _initializationSettingsAndroid,
    _initializationSettingsIOS,
  );
  static final _androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'wash_hands_notification',
    'wash hands notification',
    'Time to wash hands',
    icon: 'secondary_icon',
    enableVibration: true,
    playSound: true,
  );
  static final _iOSPlatformChannelSpecifics = IOSNotificationDetails(
    presentAlert: true,
    presentSound: true,
  );
  static final _platformChannelSpecifics =
      NotificationDetails(_androidPlatformChannelSpecifics, _iOSPlatformChannelSpecifics);
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final SettingsRepository _settingsRepository;

  NotificationBloc({@required SettingsRepository settingsRepository})
      : assert(settingsRepository != null),
        _settingsRepository = settingsRepository;

  @override
  NotificationState get initialState => NotificationInitial();

  @override
  Stream<NotificationState> mapEventToState(final NotificationEvent event) async* {
    if (event is NotificationStarted) {
      yield* _mapStartingToState();
    }
  }

  Stream<NotificationState> _mapStartingToState() async* {
    await _initializePlugin();
    await _flutterLocalNotificationsPlugin.cancelAll();

    List<PendingNotificationRequest> requests = await _flutterLocalNotificationsPlugin.pendingNotificationRequests();

    if (requests.isEmpty) {
      final Duration fromTime = await _settingsRepository.getFromTime();
      final Duration toTime = await _settingsRepository.getToTime();
      final Duration interval = await _settingsRepository.getRepeatInterval();

      await _scheduleNotification(fromTime, toTime, interval);
    }
  }

  Future _initializePlugin() async {
    await _flutterLocalNotificationsPlugin.initialize(
      _initializationSettings,
      onSelectNotification: (String payload) async {},
    );
  }

  Future<void> _scheduleNotification(
    final Duration fromTime,
    final Duration toTime,
    final Duration interval,
  ) async {
    int id = 0;
    DateTime start = DateTime(1970).add(fromTime);
    final end = DateTime(1970).add(toTime);

    do {
      await _flutterLocalNotificationsPlugin.showDailyAtTime(
        id,
        'Hands wash time',
        '',
        Time(start.hour, start.minute),
        _platformChannelSpecifics,
      );
      start = start.add(interval);
      id += 1;
    } while (start.isBefore(end) || start.isAtSameMomentAs(end));
  }

  Future<void> _clearNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
