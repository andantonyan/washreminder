import 'package:app/blocs/blocs.dart';
import 'package:app/core/core.dart';
import 'package:app/ui/commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_tab.dart';
import 'bloc/bloc.dart';
import 'dashboard.dart';
import 'settings.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
        notificationBloc: BlocProvider.of<NotificationBloc>(context),
        settingsRepository: injector<SettingsRepository>(),
      )..add(HomeStarted()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (final context, final state) {
          if (state.loading) return LoadingScreen();

          return Scaffold(
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: _buildBody(context, state),
                ),
              ),
            ),
            bottomNavigationBar: _buildBottomNavigationBar(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(final BuildContext context, final HomeState state) {
    switch (state.activeTab) {
      case AppTab.dashboard:
        return Dashboard(
          isEnabled: state.isEnabled,
          scheduledHours: state.scheduledHours,
        );
      case AppTab.settings:
        return Settings(
          isEnabled: state.isEnabled,
          fromTime: state.updatedFromTime ?? state.fromTime,
          toTime: state.updatedToTime ?? state.toTime,
          interval: state.updatedInterval ?? state.interval,
          hasUnsavedChanges: state.hasUnsavedChanges,
        );
      default:
        return Container();
    }
  }

  Widget _buildBottomNavigationBar(final BuildContext context, final HomeState state) {
    return BottomNavigationBar(
      currentIndex: AppTab.values.indexOf(state.activeTab),
      onTap: (index) => _onNavigationItemTapped(context, AppTab.values[index]),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text('Settings'),
        ),
      ],
    );
  }

  void _onNavigationItemTapped(final BuildContext context, final AppTab activeTab) {
    context.bloc<HomeBloc>().add(HomeNavigationButtonPressed(tab: activeTab));
  }
}
