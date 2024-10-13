// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_metrics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllMetricsModel _$AllMetricsModelFromJson(Map<String, dynamic> json) =>
    AllMetricsModel(
      date: DateTime.parse(json['date'] as String),
      impressions: (json['impressions'] as num).toInt(),
      visitors: (json['visitors'] as num).toInt(),
      reach: (json['reach'] as num).toInt(),
      spend: (json['spend'] as num).toDouble(),
      frequency: (json['frequency'] as num).toDouble(),
      cpm: (json['cpm'] as num).toDouble(),
      ctr: (json['ctr'] as num).toDouble(),
      cpc: (json['cpc'] as num).toDouble(),
      leads: (json['leads'] as num).toInt(),
      cpr: (json['cpr'] as num).toDouble(),
    );

Map<String, dynamic> _$AllMetricsModelToJson(AllMetricsModel instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'impressions': instance.impressions,
      'visitors': instance.visitors,
      'reach': instance.reach,
      'spend': instance.spend,
      'frequency': instance.frequency,
      'cpm': instance.cpm,
      'ctr': instance.ctr,
      'cpc': instance.cpc,
      'leads': instance.leads,
      'cpr': instance.cpr,
    };
