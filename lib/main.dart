import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';
import 'di_registry.dart';
import 'ui/ui.dart';

void main() {
  BlocSupervisor.delegate = LogBlocDelegate();
  configure();

  runApp(App());
}
