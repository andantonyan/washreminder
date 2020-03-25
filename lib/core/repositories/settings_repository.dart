import 'package:app/core/di/di.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SettingsRepository {
  static const _intervalStorageKey = 'selected_interval';
  static const _fromTimeStorageKey = 'from_time';
  static const _toTimeStorageKey = 'to_time';

  static const _defaultInterval = Duration(minutes: 2);
  static final _defaultFromTime = Duration(hours: 10);
  static final _defaultToTime = Duration(hours: 24);

  final _storage = injector<FlutterSecureStorage>();

  Future<void> updateInterval(final Duration duration) async {
    await _storage.write(key: _intervalStorageKey, value: duration.toString());
  }

  Future<Duration> getRepeatInterval() async {
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
