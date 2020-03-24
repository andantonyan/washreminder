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
      create: (context) => HomeBloc()..add(HomeStarted()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (final context, final state) {
          return Scaffold(
            body: SafeArea(child: _buildBody(context, state)),
            bottomNavigationBar: _buildBottomNavigationBar(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(final BuildContext context, final HomeState state) {
    switch (state.activeTab) {
      case AppTab.dashboard:
        return Dashboard();
      case AppTab.settings:
        return Settings();
      default:
        return Container();
    }
  }

  Widget _buildBottomNavigationBar(final BuildContext context, final HomeState state) {
    return BottomNavigationBar(
      elevation: 0,
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
