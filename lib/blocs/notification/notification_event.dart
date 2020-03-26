import 'package:meta/meta.dart';

@immutable
abstract class NotificationEvent {
  const NotificationEvent();
}

class NotificationStarted extends NotificationEvent {}

class NotificationReschedule extends NotificationEvent {}

class NotificationClear extends NotificationEvent {}
