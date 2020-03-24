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
