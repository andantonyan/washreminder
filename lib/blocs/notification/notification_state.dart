import 'package:app/blocs/states/states.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NotificationState {
  const NotificationState();
}

class NotificationInitial extends NotificationState {}

class NotificationInProgress extends NotificationState {}

class NotificationScheduled extends NotificationState {}

class NotificationEmpty extends NotificationState {}

class NotificationFailure extends NotificationState implements ErrorState {
  @override
  final String error;

  const NotificationFailure({@required this.error});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationFailure && runtimeType == other.runtimeType && error == other.error;

  @override
  int get hashCode => error.hashCode;
}
