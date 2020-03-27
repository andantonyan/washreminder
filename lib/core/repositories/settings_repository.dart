import 'package:app/commons/commons.dart';
import 'package:app/core/di/di.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SettingsRepository {
  static const _notificationsEnabledStorageKey = 'notification_enabled';
  static const _intervalStorageKey = 'selected_interval';
  static const _fromTimeStorageKey = 'from_time';
  static const _toTimeStorageKey = 'to_time';

  static const _defaultInterval = Duration(minutes: 60);
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
    return duration != null ? parseDuration(duration) : _defaultInterval;
  }

  Future<void> updateFromTime(final Duration duration) async {
    await _storage.write(key: _fromTimeStorageKey, value: duration.toString());
  }

  Future<Duration> getFromTime() async {
    final duration = await _storage.read(key: _fromTimeStorageKey);
    return duration != null ? parseDuration(duration) : _defaultFromTime;
  }

  Future<void> updateToTime(final Duration duration) async {
    await _storage.write(key: _toTimeStorageKey, value: duration.toString());
  }

  Future<Duration> getToTime() async {
    final duration = await _storage.read(key: _toTimeStorageKey);
    return duration != null ? parseDuration(duration) : _defaultToTime;
  }
}
