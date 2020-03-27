import 'package:app/ui/commons/commons.dart';
import 'package:flutter/material.dart';

import 'clock.dart';

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
            'Let\'s make bacteria away',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.w600, color: AppColors.text),
          ),
          const SizedBox(height: 30),
          Clock(
            fromTime: fromTime,
            toTime: toTime,
            interval: interval,
            isEnabled: isEnabled,
          ),
          const SizedBox(height: 30),
          RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              style: Theme.of(context).textTheme.body1.copyWith(color: AppColors.text, height: 2.2),
              children: <TextSpan>[
                TextSpan(text: 'Wash your hands frequently\n', style: TextStyle(fontWeight: FontWeight.w600)),
                TextSpan(
                    text:
                    'Regularly and thoroughly clean your hands with an alcohol-based hand rub or wash them with soap and water.\n'),
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'Why? ', style: TextStyle(fontWeight: FontWeight.w600)),
                    TextSpan(text: 'Washing your hands with soap and water or using alcohol-based hand rub kills viruses that may be on your hands.')
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
