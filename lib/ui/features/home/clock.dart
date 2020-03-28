import 'dart:async';

import 'package:app/commons/commons.dart';
import 'package:app/ui/commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
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
  Duration _progress;
  Duration _start;
  Duration _end;

  @override
  void initState() {
    super.initState();
    _calculate();
    _setupTimer();
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SleekCircularSlider(
          appearance: CircularSliderAppearance(
            animationEnabled: false,
            customWidths: CustomSliderWidths(trackWidth: 20, progressBarWidth: 20, shadowWidth: 0),
            customColors: CustomSliderColors(
              trackColor: AppColors.lightGray,
              progressBarColor: widget.isEnabled ? AppColors.primary : AppColors.lightGray,
              hideShadow: true,
              dotColor: AppColors.transparent,
            ),
            size: 250,
          ),
          min: 0,
          max: widget.interval?.inSeconds?.toDouble() ?? 0,
          initialValue: _progress.inSeconds.toDouble(),
          innerWidget: (final double value) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                SizedBox(
                  height: 150,
                  child: Icon(
                    widget.isEnabled ? Icons.alarm : Icons.alarm_off,
                    color: widget.isEnabled ? AppColors.accent.withOpacity(.5) : AppColors.lightGray,
                    size: 130,
                  ),
                ),
                _buildTimer(context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTimer(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            widget.isEnabled ? formatDuration(_start) : '--:--',
            style: Theme.of(context).textTheme.headline.copyWith(
                color: widget.isEnabled ? AppColors.accent.withOpacity(.7) : AppColors.lightGray,
                fontWeight: FontWeight.w600),
          ),
          Text(
            widget.isEnabled ? formatDuration(_end) : '--:--',
            style: Theme.of(context).textTheme.headline.copyWith(
                color: widget.isEnabled ? AppColors.accent.withOpacity(.7) : AppColors.lightGray,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  void _calculate() {
    final now = DateTime.now();

    Duration fromTime = widget.fromTime ?? Duration();
    Duration toTime = widget.toTime ?? Duration();
    Duration currentTime = Duration(hours: now.hour, minutes: now.minute, seconds: now.second);

    if (fromTime.compareTo(toTime) > 0) {
      toTime = Duration(seconds: toTime.inSeconds, days: 1);
    }

    final secondsPassed = currentTime.inSeconds - fromTime.inSeconds;
    final isActive = currentTime.compareTo(fromTime) > 0 && currentTime.compareTo(toTime) < 0;
    _progress = Duration(
      seconds: (!isActive || !widget.isEnabled) ? 0 : (secondsPassed % widget?.interval?.inSeconds),
    );
    _start = isActive ? Duration(seconds: currentTime.inSeconds - _progress.inSeconds) : fromTime;
    _end = Duration(seconds: _start.inSeconds + (widget.interval?.inSeconds ?? 0));

    if (mounted) {
      setState(() {
        _progress = _progress;
        _start = _start;
        _end = _end;
      });
    }

    if (isActive && widget.isEnabled && _progress.inSeconds == 0) {
      _onEnd();
    }
  }

  void _setupTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _calculate());
  }

  void _cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  void _onEnd() {
    _cancelTimer();

    showPlatformDialog(
      context: context,
      builder: (BuildContext context) {
        return PlatformAlertDialog(
          title: Text('Hey!'),
          content: Text('Wash your hands often to stay healthy.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Close'),
              onPressed: Navigator.of(context).pop,
            )
          ],
        );
      },
    ).then((_) {
      _calculate();
      _setupTimer();
    });
  }
}
