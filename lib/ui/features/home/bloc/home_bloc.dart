import 'package:app/blocs/blocs.dart';
import 'package:app/core/core.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../app_tab.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final NotificationBloc _notificationBloc;
  final SettingsRepository _settingsRepository;

  HomeBloc({
    @required NotificationBloc notificationBloc,
    @required SettingsRepository settingsRepository,
  })  : assert(notificationBloc != null),
        assert(settingsRepository != null),
        _notificationBloc = notificationBloc,
        _settingsRepository = settingsRepository;

  HomeState get initialState => HomeState.empty();

  @override
  Stream<HomeState> mapEventToState(final HomeEvent event) async* {
    if (event is HomeStarted) {
      yield* _mapStartedToState();
    } else if (event is HomeNavigationButtonPressed) {
      yield* _mapNavigationButtonPressedToState(event.tab);
    } else if (event is HomeDisableButtonPressed) {
      yield* _mapDisablePressedToState();
    } else if (event is HomeEnableButtonPressed) {
      yield* _mapEnablePressedToState();
    } else if (event is HomeIntervalChanged) {
      yield* _mapIntervalChangeToState(event.interval);
    } else if (event is HomeFromTimeChanged) {
      yield* _mapFromTimeChangeToState(event.fromTime);
    } else if (event is HomeToTimeChanged) {
      yield* _mapToTimeChangeToState(event.toTime);
    }
  }

  Stream<HomeState> _mapStartedToState() async* {
    yield state.update(loading: true);

    yield state.update(
      activeTab: AppTab.dashboard,
      isEnabled: await _settingsRepository.isNotificationsEnabled(),
      fromTime: await _settingsRepository.getFromTime(),
      toTime: await _settingsRepository.getToTime(),
      interval: await _settingsRepository.getInterval(),
    );
  }

  Stream<HomeState> _mapNavigationButtonPressedToState(final AppTab tab) async* {
    yield state.update(activeTab: tab);
  }

  Stream<HomeState> _mapDisablePressedToState() async* {
    await _settingsRepository.disableNotifications();
    _notificationBloc.add(NotificationClear());
    yield state.update(isEnabled: false);
  }

  Stream<HomeState> _mapEnablePressedToState() async* {
    await _settingsRepository.enableNotifications();
    _notificationBloc.add(NotificationReschedule());
    yield state.update(isEnabled: true);
  }

  Stream<HomeState> _mapIntervalChangeToState(final Duration interval) async* {
    await _settingsRepository.updateInterval(interval);
    _notificationBloc.add(NotificationReschedule());
    yield state.update(interval: interval);
  }

  Stream<HomeState> _mapFromTimeChangeToState(final Duration fromTime) async* {
    final toTime = state.toTime.compareTo(fromTime) < 0 ? fromTime : null;
    await _settingsRepository.updateFromTime(fromTime);

    if (toTime != null) await _settingsRepository.updateToTime(toTime);

    _notificationBloc.add(NotificationReschedule());
    yield state.update(fromTime: fromTime, toTime: toTime);
  }

  Stream<HomeState> _mapToTimeChangeToState(final Duration toTime) async* {
    final fromTime = state.fromTime.compareTo(toTime) > 0 ? toTime : null;
    await _settingsRepository.updateToTime(toTime);

    if (fromTime != null) await _settingsRepository.updateFromTime(fromTime);

    _notificationBloc.add(NotificationReschedule());
    yield state.update(toTime: toTime, fromTime: fromTime);
  }
}
