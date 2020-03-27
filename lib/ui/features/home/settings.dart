import 'package:app/ui/commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import 'bloc/bloc.dart';

class Settings extends StatelessWidget {
  final bool isEnabled;
  final Duration fromTime;
  final Duration toTime;
  final Duration interval;
  final bool hasUnsavedChanges;

  const Settings({
    @required this.isEnabled,
    @required this.fromTime,
    @required this.toTime,
    @required this.interval,
    this.hasUnsavedChanges,
  });

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 40),
        _buildConfigChangeSection(context),
        const SizedBox(height: 20),
        _buildFooter(context),
        const SizedBox(height: 20),
      ],
    );
  }

  _buildConfigChangeSection(final BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: isEnabled ? 1 : .5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 40),
          Row(
            children: <Widget>[
              Text(
                'Change time range',
                style: Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.w600, color: AppColors.text),
              ),
              const SizedBox(width: 5),
              Icon(Icons.access_time, color: AppColors.text),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildTimePicker(
                context: context,
                label: 'From',
                value: fromTime,
                onConfirm: (time) => _onFromTimeChange(context, time),
              ),
              const SizedBox(width: 30),
              _buildTimePicker(
                context: context,
                label: 'To',
                value: toTime,
                onConfirm: (time) => _onToTimeChange(context, time),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            children: <Widget>[
              Text(
                'Change period',
                style: Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.w600, color: AppColors.text),
              ),
              const SizedBox(width: 5),
              Icon(Icons.timer, color: AppColors.text),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildIntervalOption(context: context, text: '20 min', value: const Duration(minutes: 20)),
              const SizedBox(width: 30),
              _buildIntervalOption(context: context, text: '30 min', value: const Duration(minutes: 30)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildIntervalOption(context: context, text: '45 min', value: const Duration(minutes: 45)),
              const SizedBox(width: 30),
              _buildIntervalOption(context: context, text: '1 hr', value: const Duration(minutes: 60)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildIntervalOption(context: context, text: '1 hr 30 min', value: const Duration(minutes: 90)),
              const SizedBox(width: 30),
              _buildIntervalOption(context: context, text: '2 hrs', value: const Duration(minutes: 120)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildIntervalOption(context: context, text: '3 hrs', value: const Duration(minutes: 180)),
              const SizedBox(width: 30),
              Expanded(child: Container(),),
            ],
          ),
        ],
      ),
    );
  }

  _buildFooter(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildActionButtons(context),
        const SizedBox(height: 20),
        Row(
          children: <Widget>[
            Expanded(child: Container()),
            const SizedBox(width: 30),
            Expanded(
              child: SizedBox(
                height: 50,
                child: _buildButton(
                  context: context,
                  icon: isEnabled
                      ? Icon(Icons.alarm_off, color: AppColors.error)
                      : Icon(Icons.alarm_on, color: AppColors.accent),
                  child: Text(
                    isEnabled ? 'Disable' : 'Enable',
                    style: TextStyle(color: isEnabled ? AppColors.error : AppColors.accent, fontWeight: FontWeight.w600),
                  ),
                  onPressed: () => isEnabled ? _onDisableButtonPressed(context) : _onEnableButtonPressed(context),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons(final BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: hasUnsavedChanges ? 1 : .5,
      child: Row(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 50,
              child: _buildButton(
                context: context,
                icon: Icon(Icons.undo, color: AppColors.text),
                child: Text('Discard', style: TextStyle(color: AppColors.text, fontWeight: FontWeight.w600)),
                onPressed: hasUnsavedChanges ? () => _onDiscardButtonPressed(context) : null,
              ),
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: SizedBox(
              height: 50,
              child: _buildButton(
                context: context,
                icon: Icon(Icons.save, color: AppColors.text),
                child: Text('Save', style: TextStyle(color: AppColors.text, fontWeight: FontWeight.w600)),
                onPressed: hasUnsavedChanges ? () => _onSaveButtonPressed(context) : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntervalOption({
    final BuildContext context,
    final String text,
    final Duration value,
  }) {
    final selected = interval.compareTo(value) == 0;

    return Expanded(
      child: SizedBox(
        height: 50,
        child: _buildButton(
          context: context,
          onPressed: isEnabled ? () => _onIntervalChange(context, value) : null,
          child: Text(
            text,
            style: TextStyle(
              color: selected ? AppColors.accent : AppColors.gray,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    final BuildContext context,
    final VoidCallback onPressed,
    final Widget child,
    final Color color = AppColors.white,
    final Icon icon,
  }) {
    if (icon != null) {
      return OutlineButton.icon(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: onPressed,
        icon: icon,
        label: child,
      );
    } else {
      return OutlineButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: onPressed,
        child: child,
      );
    }
  }

  Widget _buildTimePicker({
    final BuildContext context,
    final String label,
    final Duration value,
    final DateChangedCallback onConfirm,
  }) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day).add(value);

    return Expanded(
      child: _buildButton(
        context: context,
        onPressed: isEnabled
            ? () {
                DatePicker.showTimePicker(
                  context,
                  theme: DatePickerTheme(containerHeight: 210),
                  showSecondsColumn: false,
                  showTitleActions: true,
                  onConfirm: onConfirm,
                  currentTime: dateTime,
                );
              }
            : null,
        child: SizedBox(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('$label ', style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.w600)),
              Expanded(child: Container()),
              Icon(Icons.access_time, size: 18, color: AppColors.accent),
              Text(
                ' ${DateFormat('Hm').format(dateTime)}',
                style: TextStyle(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onToTimeChange(BuildContext context, DateTime time) {
    return BlocProvider.of<HomeBloc>(context)
        .add(HomeToTimeChanged(toTime: Duration(hours: time.hour, minutes: time.minute)));
  }

  void _onFromTimeChange(BuildContext context, DateTime time) {
    return BlocProvider.of<HomeBloc>(context)
        .add(HomeFromTimeChanged(fromTime: Duration(hours: time.hour, minutes: time.minute)));
  }

  void _onIntervalChange(BuildContext context, Duration value) {
    BlocProvider.of<HomeBloc>(context).add(HomeIntervalChanged(interval: value));
  }

  void _onDisableButtonPressed(BuildContext context) {
    return BlocProvider.of<HomeBloc>(context).add(HomeDisableButtonPressed());
  }

  void _onEnableButtonPressed(BuildContext context) {
    return BlocProvider.of<HomeBloc>(context).add(HomeEnableButtonPressed());
  }

  void _onSaveButtonPressed(final BuildContext context) {
    return BlocProvider.of<HomeBloc>(context).add(HomeSaveButtonPressed());
  }

  void _onDiscardButtonPressed(final BuildContext context) {
    return BlocProvider.of<HomeBloc>(context).add(HomeDiscardButtonPressed());
  }
}
