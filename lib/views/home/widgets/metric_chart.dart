import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:zeely_technical_task/styles/styles.dart';

import '../../../models/models.dart';

class MetricChart extends StatelessWidget {
  const MetricChart({
    super.key,
    required this.data,
    required this.selectedMetric,
    required this.onPointerChange,
    required this.onPointerExit,
    required this.daysRange,
    required this.maxMetricValue,
  });

  final List<ChartMetricsModel> data;
  final String selectedMetric;
  final Function(int) onPointerChange;
  final VoidCallback onPointerExit;
  final List<String?> daysRange;
  final String? maxMetricValue;

  @override
  Widget build(BuildContext context) {
    final TextTheme textStyles = context.textStyles;
    final AppColors colors = context.colors;

    return Column(
      children: [
        SizedBox(
          height: 152,
          child: Stack(
            children: [
              LineChart(
                LineChartData(
                  minY: 0,
                  maxY: _parseMaxValue(),
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _getSpots(),
                      isCurved: true,
                      curveSmoothness: 0.6,
                      preventCurveOverShooting: true,
                      color: colors.black,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  lineTouchData: _getLineTouchData(colors),
                ),
              ),
              Positioned(
                bottom: 2,
                child: Text(
                  '0',
                  style: textStyles.metricRangeValue,
                ),
              ),
              Positioned(
                top: 2,
                right: 0,
                child: Text(
                  maxMetricValue ?? '',
                  style: textStyles.metricRangeValue,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: daysRange
                .map((day) => Text(day ?? '', style: textStyles.metricRangeName))
                .toList(),
          ),
        ),
      ],
    );
  }

  List<FlSpot> _getSpots() {
    final maxY = _parseMaxValue();
    final values = data.map((item) => item.getMetricValue(selectedMetric)).toList();
    final maxValue = values.reduce(math.max);
    
    return data.asMap().entries.map((entry) {
      final value = entry.value.getMetricValue(selectedMetric);
      final scaledValue = value / maxValue * maxY;
      return FlSpot(entry.key.toDouble(), scaledValue);
    }).toList();
  }

  double _parseMaxValue() {
    if (maxMetricValue == null) return 100; 
    
    final numericString = maxMetricValue!.replaceAll(RegExp('[^0-9.]'), '');
    
    try {
      return double.parse(numericString) * 1.1;
    } catch (e) {
      return 100; 
    }
  }

  LineTouchData _getLineTouchData(AppColors colors) {
    return LineTouchData(
      enabled: true,
      touchTooltipData: LineTouchTooltipData(
        tooltipPadding: EdgeInsets.zero,
        tooltipMargin: 8,
        getTooltipItems: (touchedSpots) => touchedSpots.map((_) => null).toList(),
      ),
      touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {
        if (touchResponse?.lineBarSpots != null && touchResponse!.lineBarSpots!.isNotEmpty) {
          final index = touchResponse.lineBarSpots![0].x.toInt();
          onPointerChange(index);
        } else {
          onPointerExit();
        }
      },
      handleBuiltInTouches: true,
      getTouchedSpotIndicator: (_, spots) {
        return spots.map((spot) {
          return TouchedSpotIndicatorData(
            const FlLine(color: Colors.grey, strokeWidth: 1),
            FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) => TouchIndicator(
                radius: 7,
                strokeWidth: 2,
                strokeColor: Colors.white,
                color: Colors.black,
              ),
            ),
          );
        }).toList();
      },
    );
  }
}

class TouchIndicator extends FlDotPainter {
  TouchIndicator({
    required this.radius,
    required this.strokeWidth,
    required this.strokeColor,
    required this.color,
  });

  final double radius;
  final double strokeWidth;
  final Color strokeColor;
  final Color color;

  @override
  void draw(Canvas canvas, FlSpot spot, Offset offsetInCanvas) {
    canvas.drawCircle(
      offsetInCanvas,
      radius,
      Paint()..color = strokeColor,
    );
    canvas.drawCircle(
      offsetInCanvas,
      radius - strokeWidth,
      Paint()..color = color,
    );
  }

  @override
  Size getSize(FlSpot spot) => Size(radius * 2, radius * 2);

  @override
  List<Object?> get props => [radius, strokeWidth, strokeColor, color];

  @override
  FlDotPainter lerp(FlDotPainter a, FlDotPainter b, double t) {
    if (a is TouchIndicator && b is TouchIndicator) {
      return TouchIndicator(
        radius: ui.lerpDouble(a.radius, b.radius, t)!,
        strokeWidth: ui.lerpDouble(a.strokeWidth, b.strokeWidth, t)!,
        strokeColor: Color.lerp(a.strokeColor, b.strokeColor, t)!,
        color: Color.lerp(a.color, b.color, t)!,
      );
    }
    return this;
  }

  @override
  Color get mainColor => color;
}
