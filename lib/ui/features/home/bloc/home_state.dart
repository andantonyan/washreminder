import 'package:app/blocs/states/states.dart';
import 'package:meta/meta.dart';

import '../app_tab.dart';

@immutable
class HomeState implements LoadingState {
  final AppTab activeTab;
  final bool isEnabled;
  final Duration fromTime;
  final Duration toTime;
  final Duration interval;

  @override
  final bool loading;

  const HomeState({
    this.activeTab,
    this.isEnabled,
    this.fromTime,
    this.toTime,
    this.interval,
    this.loading,
  });

  factory HomeState.empty() {
    return HomeState(activeTab: AppTab.dashboard, loading: false);
  }

  HomeState update({
    AppTab activeTab,
    bool isEnabled,
    Duration fromTime,
    Duration toTime,
    Duration interval,
    bool loading,
  }) {
    return copyWith(
      activeTab: activeTab,
      isEnabled: isEnabled,
      fromTime: fromTime,
      toTime: toTime,
      interval: interval,
      loading: loading ?? false
    );
  }

  HomeState copyWith({
    AppTab activeTab,
    bool isEnabled,
    Duration fromTime,
    Duration toTime,
    Duration interval,
    bool loading,
  }) {
    return new HomeState(
      activeTab: activeTab ?? this.activeTab,
      isEnabled: isEnabled ?? this.isEnabled,
      fromTime: fromTime ?? this.fromTime,
      toTime: toTime ?? this.toTime,
      interval: interval ?? this.interval,
      loading: loading ?? this.loading,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeState &&
          runtimeType == other.runtimeType &&
          activeTab == other.activeTab &&
          isEnabled == other.isEnabled &&
          fromTime == other.fromTime &&
          toTime == other.toTime &&
          interval == other.interval &&
          loading == other.loading;

  @override
  int get hashCode =>
      activeTab.hashCode ^
      isEnabled.hashCode ^
      fromTime.hashCode ^
      toTime.hashCode ^
      interval.hashCode ^
      loading.hashCode;

  @override
  String toString() {
    return 'HomeState{activeTab: $activeTab, isEnabled: $isEnabled, fromTime: $fromTime, toTime: $toTime, interval: $interval, loading: $loading}';
  }
}
