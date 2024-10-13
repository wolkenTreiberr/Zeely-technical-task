part of 'styles.dart';

extension TextStylesFromContext on BuildContext {
  TextTheme get textStyles => Theme.of(this).textTheme;
}

extension AppColorsFromContext on BuildContext {
  AppColors get colors => AppColors.of(this);
}

extension CustomTextStyle on TextTheme {
  TextStyle get metricTabName => const TextStyle(
        fontFamily: 'Saint',
        fontSize: 14,
        fontWeight: FontWeight.w600,
      );

  TextStyle get metricValueCounter => const TextStyle(
        fontFamily: 'Saint',
        fontSize: 48,
        fontWeight: FontWeight.w500,
        height: 0.76,
      );

  TextStyle get metricValueDate => const TextStyle(
        fontFamily: 'Saint',
        fontSize: 12,
        fontWeight: FontWeight.w500,
      );

  TextStyle get metricRangeValue => const TextStyle(
        fontFamily: 'Saint',
        fontSize: 10,
        fontWeight: FontWeight.w600,
      );

  TextStyle get metricRangeName => TextStyle(
        fontFamily: 'Saint',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 0.3,
        color: colors.grey2,
      );

  TextStyle get metricRangePeriod => TextStyle(
        fontFamily: 'Saint',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 0.3,
        color: colors.grey1,
      );

  TextStyle get calendarTitle => const TextStyle(
        fontFamily: 'Saint',
        fontSize: 22,
        fontWeight: FontWeight.w700,
      );

  TextStyle get calendarRange => const TextStyle(
        fontFamily: 'Saint',
        fontSize: 18,
        fontWeight: FontWeight.w600,
      );

  TextStyle get calendarSubtitle => TextStyle(
        fontFamily: 'Saint',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: colors.grey1,
      );

  TextStyle get calendarPickedDate => TextStyle(
        fontFamily: 'Saint',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: colors.white,
      );

  TextStyle get calendarDate => TextStyle(
        fontFamily: 'Saint',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: colors.black,
      );

  TextStyle get calendarDisabledDate => TextStyle(
        fontFamily: 'Saint',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: colors.grey3,
      );

  TextStyle get calendarApply => TextStyle(
        fontFamily: 'Saint',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: colors.white,
      );
}
