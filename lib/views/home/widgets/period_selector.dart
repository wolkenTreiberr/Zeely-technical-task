import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeely_technical_task/enums/period_type_enum.dart';
import 'package:zeely_technical_task/styles/styles.dart';

class PeriodSelector extends StatelessWidget {
  const PeriodSelector({
    super.key,
    required this.periods,
    required this.selectedPeriod,
    required this.onPeriodSelected,
    required this.onCustomRangeSelected,
  });

  final List<PeriodType> periods;
  final PeriodType selectedPeriod;
  final ValueChanged<PeriodType> onPeriodSelected;
  final VoidCallback onCustomRangeSelected;

  static const double _iconSize = 16.0;
  static const double _bottomBorderWidth = 2.0;

  @override
  Widget build(BuildContext context) {
    final TextTheme textStyles = context.textStyles;
    final AppColors colors = context.colors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 41,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: periods.map((period) => _buildPeriodItem(period, textStyles, colors)).toList(),
          ),
        ),
        DottedLine(
          dashColor: colors.grey3,
          lineThickness: 1,
          dashLength: 4,
          dashGapLength: 3,
        ),
      ],
    );
  }

  Widget _buildPeriodItem(PeriodType period, TextTheme textStyles, AppColors colors) {
    final bool isSelected = period == selectedPeriod;
    return GestureDetector(
      onTap: () => period == PeriodType.custom ? onCustomRangeSelected() : onPeriodSelected(period),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? colors.black : Colors.transparent,
              width: _bottomBorderWidth,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (period == PeriodType.custom)
              Padding(
                padding: const EdgeInsets.only(right: 3),
                child: SvgPicture.asset(
                  'assets/icons/metric_chart/calendar.svg',
                  width: _iconSize,
                  height: _iconSize,
                ),
              ),
            Text(
              period.label,
              style: textStyles.metricRangePeriod,
            ),
          ],
        ),
      ),
    );
  }
}
