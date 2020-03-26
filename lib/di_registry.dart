import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

import 'core/core.dart';

void configure() {
  injector.registerSingleton<Logger>(Logger());
  injector.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage());
  injector.registerSingleton<SettingsRepository>(SettingsRepository());
}
