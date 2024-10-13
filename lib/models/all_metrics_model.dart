import 'package:json_annotation/json_annotation.dart';

part 'all_metrics_model.g.dart';

@JsonSerializable()
class AllMetricsModel {
  AllMetricsModel({
    required this.date,
    required this.impressions,
    required this.visitors,
    required this.reach,
    required this.spend,
    required this.frequency,
    required this.cpm,
    required this.ctr,
    required this.cpc,
    required this.leads,
    required this.cpr,
  });

  factory AllMetricsModel.fromJson(Map<String, dynamic> json) => _$AllMetricsModelFromJson(json);
  
  @JsonKey(name: 'date')
  final DateTime date;
  @JsonKey(name: 'impressions')
  final int impressions;
  @JsonKey(name: 'visitors')
  final int visitors;
  @JsonKey(name: 'reach')
  final int reach;
  @JsonKey(name: 'spend')
  final double spend;
  @JsonKey(name: 'frequency')
  final double frequency;
  @JsonKey(name: 'cpm')
  final double cpm;
  @JsonKey(name: 'ctr')
  final double ctr;
  @JsonKey(name: 'cpc')
  final double cpc;
  @JsonKey(name: 'leads')
  final int leads;
  @JsonKey(name: 'cpr')
  final double cpr;

  Map<String, dynamic> toJson() => _$AllMetricsModelToJson(this);
}
