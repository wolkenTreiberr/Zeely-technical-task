import 'package:json_annotation/json_annotation.dart';

enum MetricType {
  @JsonValue('reach')
  clicks,
  @JsonValue('spend')
  spent,
  @JsonValue('cpm')
  costPerMille;

  String get label => switch (this) {
        clicks => 'Clicks',
        spent => 'Spent',
        costPerMille => 'Cost per mille',
      };
  
  String get name => switch (this) {
        clicks => 'reach',
        spent => 'spend',
        costPerMille => 'cpm',
      };
}
