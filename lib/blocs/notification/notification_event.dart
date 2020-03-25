import 'package:meta/meta.dart';

@immutable
abstract class NotificationEvent {
  const NotificationEvent();
}

class NotificationStarted extends NotificationEvent {}
