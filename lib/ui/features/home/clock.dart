import 'dart:async';

import 'package:app/commons/commons.dart';
import 'package:app/ui/commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Clock extends StatefulWidget {
  final bool isEnabled;
  final List<ScheduledHour> scheduledHours;

  Clock({
    Key key,
    @required this.isEnabled,
    @required this.scheduledHours,
  }) : super(key: key);

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  Timer _timer;
  Duration _from;
  Duration _to;
  double _max = 1.0;
  double _initialValue = 0.0;

  bool get _isActive => widget.isEnabled && _from != null && _to != null;

  @override
  void initState() {
    super.initState();
    _calculate();
    _setupTimer();
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
              progressBarColor: _isActive ? AppColors.primary : AppColors.lightGray,
              hideShadow: true,
              dotColor: AppColors.transparent,
            ),
            size: 250,
          ),
          min: 0,
          max: _max,
          initialValue: _initialValue,
          innerWidget: (final double value) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                SizedBox(
                  height: 150,
                  child: Icon(
                    _isActive ? Icons.alarm : Icons.alarm_off,
                    color: _isActive ? AppColors.accent.withOpacity(.5) : AppColors.lightGray,
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
          _buildTime(context, _from),
          _buildTime(context, _to),
        ],
      ),
    );
  }

  Widget _buildTime(final BuildContext context, final Duration time) {
    return Text(
      _isActive ? formatDuration(time) : '--:--',
      style: Theme.of(context).textTheme.headline.copyWith(
          color: _isActive ? AppColors.accent.withOpacity(.7) : AppColors.lightGray, fontWeight: FontWeight.w600),
    );
  }

  // FIXME: to expensive calculation
  void _calculate() {
    final now = DateTime.now();
    final currentTime = Duration(hours: now.hour, minutes: now.minute, seconds: now.second);

    final scheduledHour = widget.scheduledHours.firstWhere(
      (s) => currentTime.compareTo(s.from) >= 0 && currentTime.compareTo(s.to) < 0,
      orElse: () => ScheduledHour(null, null),
    );

    _from = scheduledHour.from;
    _to = scheduledHour.to;

    _max = _isActive ? (_to.inSeconds - _from.inSeconds).toDouble() : 1.0;
    _initialValue = _isActive ? (currentTime.inSeconds - _from.inSeconds).toDouble() : 0.0;

    if (mounted) {
      setState(() {
        _from = _from;
        _to = _to;
        _initialValue = _initialValue;
        _max = _max;
      });

      if (_isActive && _initialValue == 0.0) _onEnd();
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

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }
}
