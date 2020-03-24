import 'package:app/ui/commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class Dashboard extends StatelessWidget {
  const Dashboard();

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const SizedBox(height: 100),
        Text(
          'Let\'s keep our hands cleaned',
          style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.w600, color: AppColors.primary),
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
        const SizedBox(height: 10),
        Expanded(
          child: Timeline(
            shrinkWrap: false,
            lineWidth: 1.3,
            lineColor: AppColors.negroni,
            children: [
              TimelineModel(
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                  child: Text(
                    '10:00',
                    style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.w300),
                  ),
                ),
                position: TimelineItemPosition.left,
                iconBackground: AppColors.primary,
                icon: Icon(Icons.notifications_active, color: AppColors.white, size: 20),
              ),
              TimelineModel(
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                  child: Text(
                    '10:30',
                    style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.w300),
                  ),
                ),
                position: TimelineItemPosition.right,
                iconBackground: AppColors.primary,
                icon: Icon(Icons.notifications_active, color: AppColors.white, size: 20),
              ),
              TimelineModel(
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                  child: Text(
                    '11:00',
                    style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.w300),
                  ),
                ),
                position: TimelineItemPosition.left,
                iconBackground: AppColors.error,
                icon: Icon(Icons.notifications_off, color: AppColors.white, size: 20),
              ),
              TimelineModel(
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                  child: Text(
                    '10:30',
                    style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.w300),
                  ),
                ),
                position: TimelineItemPosition.right,
                iconBackground: AppColors.primary,
                icon: Icon(Icons.notifications_active, color: AppColors.white, size: 20),
              ),
              TimelineModel(
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                  child: Text(
                    '10:30',
                    style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.w300),
                  ),
                ),
                position: TimelineItemPosition.left,
                iconBackground: AppColors.primary,
                icon: Icon(Icons.notifications_active, color: AppColors.white, size: 20),
              ),
              TimelineModel(
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                  child: Text(
                    '11:00',
                    style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.w300),
                  ),
                ),
                position: TimelineItemPosition.right,
                iconBackground: AppColors.error,
                icon: Icon(Icons.notifications_off, color: AppColors.white, size: 20),
              ),
              TimelineModel(
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                  child: Text(
                    '11:30',
                    style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.w300),
                  ),
                ),
                position: TimelineItemPosition.left,
                iconBackground: AppColors.primary,
                icon: Icon(Icons.notifications_active, color: AppColors.white, size: 20),
              ),
            ],
            position: TimelinePosition.Center,
          ),
        )
      ],
    );
  }
}
