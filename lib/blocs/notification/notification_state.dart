import 'package:app/blocs/states/states.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NotificationState {
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is NotificationInitial && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class NotificationFailure extends NotificationState implements ErrorState {
  @override
  final String error;

  const NotificationFailure({@required this.error});
}
