import 'package:app/blocs/states/states.dart';
import 'package:meta/meta.dart';

import '../app_tab.dart';

@immutable
class HomeState implements LoadingState {
  final AppTab activeTab;
  final bool isEnabled;
  final Duration fromTime;
  final Duration updatedFromTime;
  final Duration toTime;
  final Duration updatedToTime;
  final Duration interval;
  final Duration updatedInterval;

  bool get isFromTimeUpdated => (updatedFromTime != null && updatedFromTime.compareTo(fromTime) != 0);

  bool get isToTimeUpdated => (updatedToTime != null && updatedToTime.compareTo(toTime) != 0);

  bool get isIntervalUpdated => (updatedInterval != null && updatedInterval.compareTo(interval) != 0);

  bool get hasUnsavedChanges => isFromTimeUpdated || isToTimeUpdated || isIntervalUpdated;

  @override
  final bool loading;

  const HomeState({
    this.activeTab,
    this.isEnabled,
    this.fromTime,
    this.updatedFromTime,
    this.toTime,
    this.updatedToTime,
    this.interval,
    this.updatedInterval,
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
    Duration updatedFromTime,
    Duration updatedToTime,
    Duration updatedInterval,
    bool loading,
  }) {
    return HomeState(
      activeTab: activeTab ?? this.activeTab,
      isEnabled: isEnabled ?? this.isEnabled,
      fromTime: fromTime ?? this.fromTime,
      toTime: toTime ?? this.toTime,
      interval: interval ?? this.interval,
      loading: loading ?? false,
      updatedToTime: updatedToTime,
      updatedFromTime: updatedFromTime,
      updatedInterval: updatedInterval,
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
          updatedFromTime == other.updatedFromTime &&
          toTime == other.toTime &&
          updatedToTime == other.updatedToTime &&
          interval == other.interval &&
          updatedInterval == other.updatedInterval &&
          loading == other.loading;

  @override
  int get hashCode =>
      activeTab.hashCode ^
      isEnabled.hashCode ^
      fromTime.hashCode ^
      updatedFromTime.hashCode ^
      toTime.hashCode ^
      updatedToTime.hashCode ^
      interval.hashCode ^
      updatedInterval.hashCode ^
      loading.hashCode;

  @override
  String toString() {
    return 'HomeState{activeTab: $activeTab, isEnabled: $isEnabled, fromTime: $fromTime, updatedFromTime: $updatedFromTime, toTime: $toTime, updatedToTime: $updatedToTime, interval: $interval, updatedInterval: $updatedInterval, loading: $loading}';
  }
}
