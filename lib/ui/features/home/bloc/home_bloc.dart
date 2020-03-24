import 'package:bloc/bloc.dart';

import '../app_tab.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeState get initialState => HomeState.empty();

  @override
  Stream<HomeState> mapEventToState(final HomeEvent event) async* {
    if (event is HomeStarted) {
      yield* _mapStartedToState();
    } else if (event is HomeNavigationButtonPressed) {
      yield* _mapNavigationButtonPressedToState(event.tab);
    }
  }

  Stream<HomeState> _mapStartedToState() async* {}

  Stream<HomeState> _mapNavigationButtonPressedToState(final AppTab tab) async* {
    yield state.update(activeTab: tab);
  }
}
