import 'package:meta/meta.dart';

import '../app_tab.dart';

@immutable
class HomeState {
  final AppTab activeTab;

  const HomeState({this.activeTab});

  factory HomeState.empty() {
    return HomeState(activeTab: AppTab.dashboard);
  }

  HomeState update({final AppTab activeTab}) {
    return copyWith(activeTab: activeTab);
  }

  HomeState copyWith({final AppTab activeTab}) {
    return HomeState(activeTab: activeTab ?? this.activeTab);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is HomeState && runtimeType == other.runtimeType && activeTab == other.activeTab;

  @override
  int get hashCode => activeTab.hashCode;

  @override
  String toString() {
    return 'HomeState{activeTab: $activeTab}';
  }
}
