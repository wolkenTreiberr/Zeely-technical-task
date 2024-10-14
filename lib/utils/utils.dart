import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../enums/period_type_enum.dart';

String formatMetricValue(double value, String metricType) {
  switch (metricType) {
    case 'spend':
      return '\$${value.toStringAsFixed(2).replaceAll('.', ',')}';
    case 'cpm':
      return '\$${value.toStringAsFixed(2).replaceAll('.', ',')}';
    case 'reach':
      return NumberFormat.compact().format(value).replaceAll('.', ',');
    default:
      return value.toStringAsFixed(2);
  }
}


double roundValue(double value, String metricType) {
  if (metricType == 'spend' || metricType == 'cpm') {
    return double.parse(value.toStringAsFixed(2));
  } else if (metricType == 'reach') {
    return value.roundToDouble();
  }
  return value;
}

DateTimeRange getDateRange(
  PeriodType selectedPeriod,
  DateTime currentDate,
  DateTime? firstDataDate,
  DateTimeRange customDateRange,
) {
  switch (selectedPeriod) {
    case PeriodType.all:
      return DateTimeRange(start: firstDataDate ?? DateTime(2024), end: currentDate);
    case PeriodType.last24Hours:
      return DateTimeRange(start: currentDate.subtract(const Duration(hours: 24)), end: currentDate);
    case PeriodType.last7Days:
      return DateTimeRange(start: currentDate.subtract(const Duration(days: 7)), end: currentDate);
    case PeriodType.lastMonth:
      return DateTimeRange(start: currentDate.subtract(const Duration(days: 30)), end: currentDate);
    case PeriodType.last3Months:
      return DateTimeRange(start: currentDate.subtract(const Duration(days: 90)), end: currentDate);
    case PeriodType.last6Months:
      return DateTimeRange(start: currentDate.subtract(const Duration(days: 180)), end: currentDate);
    case PeriodType.custom:
      return customDateRange;
  }
}
