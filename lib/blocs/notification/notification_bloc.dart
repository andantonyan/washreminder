import 'package:app/commons/commons.dart' as common;
import 'package:app/core/core.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
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

  final Logger _logger;
  final SettingsRepository _settingsRepository;

  NotificationBloc({@required Logger logger, @required SettingsRepository settingsRepository})
      : assert(logger != null),
        assert(settingsRepository != null),
        _logger = logger,
        _settingsRepository = settingsRepository;

  @override
  NotificationState get initialState => NotificationInitial();

  @override
  Stream<NotificationState> mapEventToState(final NotificationEvent event) async* {
    if (event is NotificationStarted) {
      yield* _mapStartingToState();
    } else if (event is NotificationReschedule) {
      yield* _mapRescheduleToState();
    }
    if (event is NotificationClear) {
      yield* _mapClearToState();
    }
  }

  Stream<NotificationState> _mapStartingToState() async* {
    yield NotificationInProgress();

    await _initializePlugin();

    List<PendingNotificationRequest> requests = await _flutterLocalNotificationsPlugin.pendingNotificationRequests();

    if (requests.isEmpty && await _settingsRepository.isNotificationsEnabled()) {
      await _scheduleNotification();
    }

    yield NotificationScheduled();
  }

  Stream<NotificationState> _mapRescheduleToState() async* {
    if (await _settingsRepository.isNotificationsEnabled()) {
      await _cancelAllNotifications();
      await _scheduleNotification();
    }

    yield NotificationScheduled();
  }

  Stream<NotificationState> _mapClearToState() async* {
    await _cancelAllNotifications();
    yield NotificationEmpty();
  }

  Future _initializePlugin() async {
    _logger.d('Initilizing notification plugin...');
    await _flutterLocalNotificationsPlugin.initialize(
      _initializationSettings,
      onSelectNotification: (String payload) async {},
    );
    _logger.i('Done initilizing notification plugin.');
  }

  Future<void> _scheduleNotification() async {
    final DateTime now = DateTime.now();
    final Duration fromTime = await _settingsRepository.getFromTime();
    final Duration toTime = await _settingsRepository.getToTime();
    final Duration interval = await _settingsRepository.getInterval();
    final List<common.Time> scheduledHours = [];

    _logger.d('Scheduling notifications FromTime:"$fromTime", ToTime:"$toTime", Interval:"$interval"...');

    DateTime start = DateTime(now.year).add(fromTime);
    final end = DateTime(now.year).add(toTime);
    int id = 0;

    if (start.isAfter(end)) start = start.subtract(Duration(days: 1));

    do {
      final time = common.Time(start.hour, start.minute, start.second);

      if (scheduledHours.contains(time)) continue;

      scheduledHours.add(time);
      _logger.d('Scheduling notification $time...');

      await _flutterLocalNotificationsPlugin.showDailyAtTime(id, 'Hey!', 'Wash your hands often to stay healthy.',
          Time(time.hour, time.minute, time.second), _platformChannelSpecifics);

      _logger.i('Done scheduling notification Time(${time.hour}:${time.minute}:${time.second}).');

      start = start.add(interval);
      id += 1;
    } while (start.isBefore(end) || start.isAtSameMomentAs(end));

    _logger.i('Done scheduling notifications \n${scheduledHours.join('\n')}.');
  }

  Future<void> _cancelAllNotifications() async {
    _logger.d('Canceling notifications...');
    await _flutterLocalNotificationsPlugin.cancelAll();
    _logger.i('Done canceling notifications.');
  }
}
