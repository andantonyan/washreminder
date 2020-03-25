import 'package:app/ui/commons/commons.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 130),
        Row(
          children: <Widget>[
            Text(
              'Change interval',
              style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.w600, color: AppColors.text),
            ),
            const SizedBox(width: 5),
            Icon(Icons.timer, color: AppColors.text),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildExpandedButton('20 min'),
            const SizedBox(width: 20),
            _buildExpandedButton('30 min'),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildExpandedButton('45 min', textColor: AppColors.primary, borderColor: AppColors.primary),
            const SizedBox(width: 20),
            _buildExpandedButton('1 hr', textColor: AppColors.text),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildExpandedButton('1 hr 30 min'),
            const SizedBox(width: 20),
            _buildExpandedButton('2 hrs'),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: <Widget>[
            Expanded(child: Container()),
            const SizedBox(width: 20),
            _buildExpandedButton(
              'Disable',
              icon: Icon(Icons.timer_off, color: AppColors.error),
              textColor: AppColors.error,
              borderColor: AppColors.error,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'Some text here, Some text here, Some text here, Some text here, Some text here, ',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            color: AppColors.text,
          ),
        ),
      ],
    );
  }

  Expanded _buildExpandedButton(
    final String text, {
    final Color textColor = AppColors.text,
    final Color borderColor = AppColors.lightGray,
    final bool disabled = false,
    final Icon icon,
  }) {
    if (icon != null) {
      return Expanded(
        child: SizedBox(
          height: 50,
          child: FlatButton.icon(
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20),
              side: BorderSide(color: borderColor, width: 1),
            ),
            icon: icon,
            label: Text(text, style: TextStyle(color: textColor)),
            onPressed: disabled ? null : () => {},
          ),
        ),
      );
    } else {
      return Expanded(
        child: SizedBox(
          height: 50,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20),
              side: BorderSide(color: borderColor, width: 1),
            ),
            child: Text(text, style: TextStyle(color: textColor)),
            onPressed: disabled ? null : () => {},
          ),
        ),
      );
    }
  }
}
