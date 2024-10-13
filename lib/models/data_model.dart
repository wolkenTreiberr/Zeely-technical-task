import 'package:json_annotation/json_annotation.dart';
import 'all_metrics_model.dart';

part 'data_model.g.dart';

@JsonSerializable()
class DataModel {
  DataModel({required this.data});

  factory DataModel.fromJson(Map<String, dynamic> json) => _$DataModelFromJson(json);

  @JsonKey(name: 'data')
  final DataContent data;

  Map<String, dynamic> toJson() => _$DataModelToJson(this);
}

@JsonSerializable()
class DataContent {
  DataContent({required this.total, required this.items});

  factory DataContent.fromJson(Map<String, dynamic> json) => _$DataContentFromJson(json);
  
  @JsonKey(name: 'total')
  final int total;
  @JsonKey(name: 'items')
  final List<AllMetricsModel> items;

  Map<String, dynamic> toJson() => _$DataContentToJson(this);
}
