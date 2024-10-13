import 'package:flutter/material.dart';

import 'styles/styles.dart';
import 'views/home/home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: originalTheme,
      home: const HomeView(),
    );
  }
}
