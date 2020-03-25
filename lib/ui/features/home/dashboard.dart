import 'package:app/ui/commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Dashboard extends StatelessWidget {
  const Dashboard();

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const SizedBox(height: 80),
        Text(
          'Let\'s keep our hands cleaned',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.w600, color: AppColors.text),
        ),
        const SizedBox(height: 30),
        CircularPercentIndicator(
          radius: 200,
          lineWidth: 15,
          percent: .3,
          center: Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset('assets/images/home_icon.png'),
          ),
          progressColor: AppColors.primary,
          backgroundColor: AppColors.lightGray,
        ),
      ],
    );
  }
}
