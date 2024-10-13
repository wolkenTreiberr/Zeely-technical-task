// ignore_for_file: library_private_types_in_public_api
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:zeely_technical_task/styles/styles.dart';
import '../../../presenters/home_provider.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    super.key,
    required this.initialDateRange,
    required this.onApply,
  });
  final DateTimeRange initialDateRange;
  final Function(DateTimeRange) onApply;

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late DateTimeRange _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _selectedDateRange = widget.initialDateRange;
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;

    return Container(
      decoration: BoxDecoration(
        color: colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            _buildDateDisplay(),
            _buildCalendar(),
            _buildApplyButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final TextTheme textStyles = context.textStyles;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Set date',
          style: textStyles.calendarTitle,
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: SvgPicture.asset(
            'assets/icons/cross_sign.svg',
            width: 30,
            height: 30,
          ),
        ),
      ],
    );
  }

  Widget _buildDateDisplay() {
    final TextTheme textStyles = context.textStyles;

    return Padding(
      padding: const EdgeInsets.only(top: 19),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${DateFormat('MMM d, yyyy').format(_selectedDateRange.start)} - ${DateFormat('MMM d, yyyy').format(_selectedDateRange.end)}',
            style: textStyles.calendarRange,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'We have data from the last 37 months here',
              style: textStyles.calendarSubtitle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    final TextTheme textStyles = context.textStyles;
    final AppColors colors = context.colors;

    return CalendarDatePicker2(
      config: CalendarDatePicker2Config(
        calendarType: CalendarDatePicker2Type.range,
        selectedDayHighlightColor: colors.blue,
        weekdayLabels: ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'],
        weekdayLabelTextStyle: textStyles.metricRangeName,
        firstDayOfWeek: 1,
        controlsHeight: 30,
        controlsTextStyle: textStyles.calendarRange,
        dayTextStyle: textStyles.calendarDate,
        disabledDayTextStyle: textStyles.calendarDisabledDate,
        selectableDayPredicate: (day) => day.isBefore(DateTime.now()),
        dayBorderRadius: BorderRadius.circular(24),
        selectedDayTextStyle: textStyles.calendarPickedDate,
      ),
      value: [_selectedDateRange.start, _selectedDateRange.end],
      onValueChanged: (dates) {
        if (dates.length == 2) {
          setState(() {
            _selectedDateRange = DateTimeRange(start: dates[0]!, end: dates[1]!);
          });
        }
      },
    );
  }

  Widget _buildApplyButton() {
    final AppColors colors = context.colors;
    final TextTheme textStyles = context.textStyles;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: () {
          widget.onApply(_selectedDateRange);
          Navigator.of(context).pop();
        },
        child: Text('Apply', style: textStyles.calendarApply),
      ),
    );
  }
}

Future<void> _showDateRangePicker(BuildContext context, HomeProvider provider) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
          child: DatePicker(
            initialDateRange: provider.dateRange,
            onApply: (newRange) {
              provider.updateCustomDateRange(newRange);
            },
          ),
        ),
      );
    },
  );
}
