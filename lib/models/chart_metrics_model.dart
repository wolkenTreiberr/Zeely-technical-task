import 'package:fl_chart/fl_chart.dart';
import 'package:json_annotation/json_annotation.dart';

import 'all_metrics_model.dart';

part 'chart_metrics_model.g.dart';

@JsonSerializable()
class ChartMetricsModel {
  ChartMetricsModel({
    required this.date,
    required this.spend,
    required this.cpm,
    required this.reach,
  });

  factory ChartMetricsModel.fromJson(Map<String, dynamic> json) => _$ChartMetricsModelFromJson(json);

  factory ChartMetricsModel.fromAllMetricsModel(AllMetricsModel model) {
    return ChartMetricsModel(
      date: model.date,
      spend: model.spend,
      cpm: model.cpm,
      reach: model.reach,
    );
  }
  
  @JsonKey(name: 'date')
  final DateTime date;
  @JsonKey(name: 'spend')
  final double spend;
  @JsonKey(name: 'cpm')
  final double cpm;
  @JsonKey(name: 'reach')
  final int reach;

  Map<String, dynamic> toJson() => _$ChartMetricsModelToJson(this);

  double getMetricValue(String metricType) {
    switch (metricType) {
      case 'spend':
        return spend;
      case 'cpm':
        return cpm;
      case 'reach':
        return reach.toDouble();
      default:
        throw ArgumentError('Unknown metric type: $metricType');
    }
  }

  String get formattedDate => '${date.day}/${date.month}';

  FlSpot toFlSpot(String metricType, int index) {
    return FlSpot(index.toDouble(), getMetricValue(metricType));
  }

  ChartMetricsModel copyWith({
    DateTime? date,
    double? spend,
    double? cpm,
    int? reach,
  }) {
    return ChartMetricsModel(
      date: date ?? this.date,
      spend: spend ?? this.spend,
      cpm: cpm ?? this.cpm,
      reach: reach ?? this.reach,
    );
  }
}