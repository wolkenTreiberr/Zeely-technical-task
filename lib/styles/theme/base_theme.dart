part of '../styles.dart';

ThemeData getTheme(AppColors colors) => ThemeData(
      useMaterial3: true,
      extensions: [colors],
      primaryColor: colors.white,
      fontFamily: 'Saint',
      splashFactory: InkRipple.splashFactory,
    );
