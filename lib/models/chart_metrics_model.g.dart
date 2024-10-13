// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_metrics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChartMetricsModel _$ChartMetricsModelFromJson(Map<String, dynamic> json) =>
    ChartMetricsModel(
      date: DateTime.parse(json['date'] as String),
      spend: (json['spend'] as num).toDouble(),
      cpm: (json['cpm'] as num).toDouble(),
      reach: (json['reach'] as num).toInt(),
    );

Map<String, dynamic> _$ChartMetricsModelToJson(ChartMetricsModel instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'spend': instance.spend,
      'cpm': instance.cpm,
      'reach': instance.reach,
    };
