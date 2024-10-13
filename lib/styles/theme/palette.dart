part of '../styles.dart';

final colors = AppColors(
  white: Colors.white,
  black: Colors.black,
  blue: const Color(0xFF2555FF),
  grey1: const Color(0xFF8F969C),
  grey2: const Color(0xFF404040),
  grey3: const Color(0xFF8F969C).withOpacity(0.2),
  pinGradient: const LinearGradient(
    colors: [
      Color(0xFFCAD4DD),
      Color.fromRGBO(202, 212, 221, 0),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.7899, 1.0],
  ),
);
