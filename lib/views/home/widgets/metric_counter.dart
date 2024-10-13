import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeely_technical_task/styles/styles.dart';

import '../../../presenters/home_provider.dart';

class MetricCounter extends StatelessWidget {
  const MetricCounter({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyles = context.textStyles;

    return SizedBox(
      height: 53,
      child: Selector<HomeProvider, (String?, String?, String)>(
        selector: (_, provider) => (
          provider.pointerValue,
          provider.pointerDate,
          provider.getFormattedTotalValue(),
        ),
        builder: (context, data, child) {
          final (pointerValue, pointerDate, totalValue) = data;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  pointerValue ?? totalValue,
                  style: textStyles.metricValueCounter,
                ),
                const SizedBox(height: 12),
                Text(
                  pointerDate ?? '',
                  style: textStyles.metricRangeName,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
