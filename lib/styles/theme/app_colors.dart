part of '../styles.dart';

class AppColors extends ThemeExtension<AppColors> {
  factory AppColors.of(BuildContext context) => Theme.of(context).extension<AppColors>()!;

  AppColors({
    required this.white,
    required this.black,
    required this.blue,
    required this.grey1,
    required this.grey2,
    required this.grey3,
    required this.pinGradient,
  });
  final Color white;
  final Color black;
  final Color blue;
  final Color grey1;
  final Color grey2;
  final Color grey3;
  final Gradient pinGradient;

  @override
  ThemeExtension<AppColors> copyWith({
    Color? white,
    Color? black,
    Color? blue,
    Color? grey1,
    Color? grey2,
    Color? grey3,
    Gradient? pinGradient,
  }) {
    return AppColors(
      white: white ?? this.white,
      black: black ?? this.black,
      blue: blue ?? this.blue,
      grey1: grey1 ?? this.grey1,
      grey2: grey1 ?? this.grey2,
      grey3: grey3 ?? this.grey3,
      pinGradient: pinGradient ?? this.pinGradient,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other == null) return this;
    if (other is! AppColors) return this;
    return AppColors(
      white: Color.lerp(white, other.white, t)!,
      black: Color.lerp(black, other.black, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
      grey1: Color.lerp(grey1, other.grey1, t)!,
      grey2: Color.lerp(grey1, other.grey2, t)!,
      grey3: Color.lerp(grey1, other.grey3, t)!,
      pinGradient: Gradient.lerp(pinGradient, other.pinGradient, t)!,
    );
  }
}
