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
    } else if (event is HomeSaveButtonPressed) {
      yield* _mapSaveButtonPressedToState();
    } else if (event is HomeDiscardButtonPressed) {
      yield* _mapDiscardButtonPressedToState();
    }
  }

  Stream<HomeState> _mapStartedToState() async* {
    yield state.update(loading: true);

    final fromTime = await _settingsRepository.getFromTime();
    final toTime = await _settingsRepository.getToTime();
    final interval = await _settingsRepository.getInterval();

    yield state.update(
      activeTab: AppTab.dashboard,
      isEnabled: await _settingsRepository.isNotificationsEnabled(),
      fromTime: fromTime,
      updatedFromTime: null,
      toTime: toTime,
      updatedToTime: null,
      interval: interval,
      updatedInterval: null,
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
    yield state.update(
      updatedInterval: interval,
      updatedToTime: state.updatedToTime ?? state.toTime,
      updatedFromTime: state.updatedFromTime ?? state.fromTime,
    );
  }

  Stream<HomeState> _mapFromTimeChangeToState(final Duration fromTime) async* {
    yield state.update(
      updatedFromTime: fromTime,
      updatedToTime: state.updatedToTime ?? state.toTime,
    );
  }

  Stream<HomeState> _mapToTimeChangeToState(final Duration toTime) async* {
    yield state.update(
      updatedFromTime: state.updatedFromTime ?? state.fromTime,
      updatedToTime: toTime,
    );
  }

  Stream<HomeState> _mapSaveButtonPressedToState() async* {
    if (state.hasUnsavedChanges) {
      if (state.isFromTimeUpdated) await _settingsRepository.updateFromTime(state.updatedFromTime);
      if (state.isToTimeUpdated) await _settingsRepository.updateToTime(state.updatedToTime);
      if (state.isIntervalUpdated) await _settingsRepository.updateInterval(state.updatedInterval);

      yield state.update(
        interval: state.updatedInterval ?? state.interval,
        fromTime: state.updatedFromTime ?? state.fromTime,
        toTime: state.updatedToTime ?? state.toTime,
        updatedInterval: null,
        updatedFromTime: null,
        updatedToTime: null,
      );

      _notificationBloc.add(NotificationReschedule());
    }
  }

  Stream<HomeState> _mapDiscardButtonPressedToState() async* {
    yield state.update(updatedInterval: null, updatedFromTime: null, updatedToTime: null);
  }
}
