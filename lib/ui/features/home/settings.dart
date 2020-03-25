import 'package:app/ui/commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 100),
        Row(
          children: <Widget>[
            Text(
              'Change time range',
              style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.w600, color: AppColors.text),
            ),
            const SizedBox(width: 5),
            Icon(Icons.access_time, color: AppColors.text),
          ],
        ),
        SizedBox(height: 10),
        _buildTimePicker(context),
        SizedBox(height: 10),
        _buildTimePicker(context),
        SizedBox(height: 40),
        Row(
          children: <Widget>[
            Text(
              'Change period',
              style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.w600, color: AppColors.text),
            ),
            const SizedBox(width: 5),
            Icon(Icons.timer, color: AppColors.text),
          ],
        ),
        const SizedBox(height: 10),
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
        const SizedBox(height: 60),
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

  RaisedButton _buildTimePicker(final BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 4.0,
      onPressed: () {
        DatePicker.showTimePicker(
          context,
          theme: DatePickerTheme(containerHeight: 210.0),
          showSecondsColumn: false,
          showTitleActions: true,
          onConfirm: (time) {
            print('confirm $time');
          },
          currentTime: DateTime.now(),
        );
      },
      child: Container(
        alignment: Alignment.center,
        height: 50.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.access_time,
                        size: 18.0,
                        color: Colors.teal,
                      ),
                      Text(
                        " 10:00",
                        style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Text(
              "  Change",
              style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ],
        ),
      ),
      color: Colors.white,
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
