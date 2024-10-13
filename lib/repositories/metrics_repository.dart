import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/models.dart';

class MetricsRepository {
  Future<DataModel> fetchMetricData() async {
    try {
      final String response = await rootBundle.loadString('assets/mocked_data.json');
      final Map<String, dynamic> jsonData = json.decode(response) as Map<String, dynamic>;
      return DataModel.fromJson(jsonData);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching metric data: $e');
      }
      rethrow;
    }
  }
}
