import 'dart:async';

import 'package:app/ui/commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Clock extends StatefulWidget {
  final bool isEnabled;
  final Duration toTime;
  final Duration fromTime;
  final Duration interval;

  Clock({
    Key key,
    @required this.isEnabled,
    @required this.fromTime,
    @required this.toTime,
    @required this.interval,
  }) : super(key: key);

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  Timer _timer;
  bool _isActive;
  Duration _progress = Duration(seconds: 0);
  Duration _remains = Duration(seconds: 0);

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), setTime);
  }

  void setTime(Timer timer) {
    final DateTime now = DateTime.now();

    DateTime start = DateTime(now.year, now.month, now.day).add(widget.fromTime);
    final end = DateTime(now.year, now.month, now.day).add(widget.toTime);

    if (start.isAfter(end)) {
      start = start.subtract(Duration(days: 1));
    }

    final bool isActive = now.isAfter(start) && now.isBefore(end);
    final secondsPassedFromStart = now.difference(start).inSeconds;
    final initialValue = Duration(
      seconds: (!isActive || !widget.isEnabled) ? 0 : (secondsPassedFromStart % widget.interval.inSeconds),
    );

    if (mounted) {
      setState(() {
        _progress = initialValue;
        _isActive = isActive;
        _remains = Duration(seconds: widget.interval.inSeconds - _progress.inSeconds);
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SleekCircularSlider(
          appearance: CircularSliderAppearance(
            customWidths: CustomSliderWidths(trackWidth: 20, progressBarWidth: 20, shadowWidth: 0),
            customColors: CustomSliderColors(
              trackColor: AppColors.lightGray,
              progressBarColor: AppColors.primary,
              dotColor: AppColors.primary,
            ),
            size: 250,
          ),
          min: 0,
          max: widget.interval?.inSeconds?.toDouble() ?? 0,
          initialValue: _progress.inSeconds.toDouble(),
          innerWidget: (double value) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/home_icon.png', width: 150),
//                Text(
//                  '${formatDuration(_remains)}',
//                  style:
//                      Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.w600, color: AppColors.accent),
//                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
