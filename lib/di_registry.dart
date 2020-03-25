import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'core/core.dart';

void configure() {
  injector.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage());
  injector.registerSingleton<SettingsRepository>(SettingsRepository());
}
