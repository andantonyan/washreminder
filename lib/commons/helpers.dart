import 'scheduled_hour.dart';

Duration parseDuration(final String s) {
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

String formatDuration(final Duration duration, [final seconds = false]) {
  String twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return '${twoDigits(duration.inHours)}:$twoDigitMinutes${seconds ? ':' + twoDigitSeconds : ''}';
}

List<ScheduledHour> calculateScheduledHours(final Duration fromTime, final Duration toTime, final Duration interval) {
  final DateTime now = DateTime.now();
  final List<ScheduledHour> scheduledHours = [];

  DateTime start = DateTime(now.year).add(fromTime);
  final end = DateTime(now.year).add(toTime);

  if (start.isAfter(end)) start = start.subtract(Duration(days: 1));

   while (start.add(interval).isBefore(end)) {
     final from = Duration(hours: start.hour, minutes: start.minute, seconds: start.second);
     start = start.add(interval);
     final to = Duration(hours: start.hour, minutes: start.minute, seconds: start.second);

     scheduledHours.add(ScheduledHour(from, to));
   };

  return scheduledHours.toSet().toList();
}
