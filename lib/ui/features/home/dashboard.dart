import 'package:app/ui/commons/commons.dart';
import 'package:app/ui/features/home/clock.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  final bool isEnabled;
  final Duration fromTime;
  final Duration toTime;
  final Duration interval;

  const Dashboard({
    @required this.isEnabled,
    @required this.fromTime,
    @required this.toTime,
    @required this.interval,
  });

  @override
  Widget build(final BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 80),
          Text(
            'Let\'s keep our hands cleaned',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.w600, color: AppColors.text),
          ),
          const SizedBox(height: 30),
          Clock(
            fromTime: fromTime,
            toTime: toTime,
            interval: interval,
            isEnabled: isEnabled,
          )
        ],
      ),
    );
  }
}
