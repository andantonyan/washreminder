import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class LogBlocDelegate extends BlocDelegate {
  final _logger = Logger();

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    _logger.d(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _logger.d(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    _logger.e(error);
  }
}
