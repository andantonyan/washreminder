import 'package:meta/meta.dart';

import '../app_tab.dart';

@immutable
abstract class HomeEvent {
  const HomeEvent();
}

class HomeStarted extends HomeEvent {}

class HomeNavigationButtonPressed extends HomeEvent {
  final AppTab tab;

  const HomeNavigationButtonPressed({@required this.tab});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeNavigationButtonPressed && runtimeType == other.runtimeType && tab == other.tab;

  @override
  int get hashCode => tab.hashCode;

  @override
  String toString() {
    return 'HomeNavigationButtonPressed{tab: $tab}';
  }
}

class HomeEnableButtonPressed extends HomeEvent {}

class HomeDisableButtonPressed extends HomeEvent {}

class HomeIntervalChanged extends HomeEvent {
  final Duration interval;

  const HomeIntervalChanged({@required this.interval});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeIntervalChanged && runtimeType == other.runtimeType && interval == other.interval;

  @override
  int get hashCode => interval.hashCode;

  @override
  String toString() {
    return 'HomeIntervalChanged{interval: $interval}';
  }
}

class HomeFromTimeChanged extends HomeEvent {
  final Duration fromTime;

  const HomeFromTimeChanged({@required this.fromTime});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeFromTimeChanged && runtimeType == other.runtimeType && fromTime == other.fromTime;

  @override
  int get hashCode => fromTime.hashCode;

  @override
  String toString() {
    return 'HomeFromTimeChanged{fromTime: $fromTime}';
  }
}

class HomeToTimeChanged extends HomeEvent {
  final Duration toTime;

  const HomeToTimeChanged({@required this.toTime});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeToTimeChanged && runtimeType == other.runtimeType && toTime == other.toTime;

  @override
  int get hashCode => toTime.hashCode;

  @override
  String toString() {
    return 'HomeToTimeChanged{toTime: $toTime}';
  }
}
