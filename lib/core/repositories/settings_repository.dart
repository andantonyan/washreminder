import 'package:app/core/di/di.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SettingsRepository {
  static const _notificationsEnabledStorageKey = 'notification_enabled';
  static const _intervalStorageKey = 'selected_interval';
  static const _fromTimeStorageKey = 'from_time';
  static const _toTimeStorageKey = 'to_time';

   static const _defaultInterval = Duration(minutes: 30);
  static final _defaultFromTime = Duration(hours: 10);
  static final _defaultToTime = Duration(hours: 22);
  static final _defaultIsNotificationsEnabled = true;

  final _storage = injector<FlutterSecureStorage>();

  Future<void> disableNotifications() async {
    await _storage.write(key: _notificationsEnabledStorageKey, value: 'false');
  }

  Future<void> enableNotifications() async {
    await _storage.write(key: _notificationsEnabledStorageKey, value: 'true');
  }

  Future<bool> isNotificationsEnabled() async {
    final isEnabled = await _storage.read(key: _notificationsEnabledStorageKey);
    return isEnabled != null ? (isEnabled == 'true') : _defaultIsNotificationsEnabled;
  }
  
  Future<void> updateInterval(final Duration duration) async {
    await _storage.write(key: _intervalStorageKey, value: duration.toString());
  }

  Future<Duration> getInterval() async {
    final duration = await _storage.read(key: _intervalStorageKey);
    return duration != null ? _parseDuration(duration) : _defaultInterval;
  }

  Future<void> updateFromTime(final Duration duration) async {
    await _storage.write(key: _fromTimeStorageKey, value: duration.toString());
  }

  Future<Duration> getFromTime() async {
    final duration = await _storage.read(key: _fromTimeStorageKey);
    return duration != null ? _parseDuration(duration) : _defaultFromTime;
  }

  Future<void> updateToTime(final Duration duration) async {
    await _storage.write(key: _toTimeStorageKey, value: duration.toString());
  }

  Future<Duration> getToTime() async {
    final duration = await _storage.read(key: _toTimeStorageKey);
    return duration != null ? _parseDuration(duration) : _defaultToTime;
  }

  Duration _parseDuration(final String s) {
    int hours = 0;
    int minutes = 0;
    int micros;

    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }

    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }
}
