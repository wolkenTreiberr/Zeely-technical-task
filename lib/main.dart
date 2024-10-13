import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeely_technical_task/app.dart';
import 'package:zeely_technical_task/presenters/home_provider.dart';
import 'package:zeely_technical_task/repositories/metrics_repository.dart';

void main() {
  final metricsRepository = MetricsRepository();

  runApp(
    ChangeNotifierProvider(
      create: (_) => HomeProvider(metricsRepository),
      child: const MyApp(),
    ),
  );
}
