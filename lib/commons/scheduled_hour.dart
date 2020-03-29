class ScheduledHour {
  final Duration from;
  final Duration to;

  const ScheduledHour(this.from, this.to);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduledHour && runtimeType == other.runtimeType && from == other.from && to == other.to;

  @override
  int get hashCode => from.hashCode ^ to.hashCode;

  @override
  String toString() {
    return 'ScheduledHour{from: $from, to: $to}';
  }
}
