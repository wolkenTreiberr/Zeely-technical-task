import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../enums/period_type_enum.dart';
import '../models/models.dart';
import '../repositories/metrics_repository.dart';
import '../utils/utils.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider(this._repository) {
    _loadData();
  }

  final MetricsRepository _repository;

  final List<ChartMetricsModel> _allData = [];
  final List<ChartMetricsModel> _filteredByRangeChartData = [];

  PeriodType _selectedPeriod = PeriodType.all;
  String _selectedMetricType = 'reach';
  late DateTime _firstDataDate;

  String? _pointerValue;
  String? _pointerDate;
  Timer? _pointerTimer;

  String? _firstDate;
  String? _middleDate;
  String? _lastDate;

  String? _maxMetricValue;

  final DateTime _currentDate = DateTime.now();
  DateTimeRange _customDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  );

  bool _isLoading = false;
  String? _error;

  static const Duration _pointerTimerDuration = Duration(milliseconds: 500);
  static final DateFormat _displayDateFormat = DateFormat('MMM d');
  static final DateFormat _pointerDateFormat = DateFormat('MMMM d');

  List<ChartMetricsModel> get filteredByRangeChartData => _filteredByRangeChartData;
  String get selectedMetricType => _selectedMetricType;
  String? get pointerValue => _pointerValue;
  String? get pointerDate => _pointerDate;
  String? get maxMetricValue => _maxMetricValue;
  String? get firstDate => _firstDate;
  String? get middleDate => _middleDate;
  String? get lastDate => _lastDate;
  bool get isLoading => _isLoading;
  String? get error => _error;
  PeriodType get selectedPeriod => _selectedPeriod;
  List<PeriodType> get availablePeriods => PeriodType.values;
  DateTimeRange get dateRange => getDateRange(_selectedPeriod, _currentDate, _firstDataDate, _customDateRange);

  Future<void> _loadData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final DataModel fetchedData = await _repository.fetchMetricData();
      _allData
        ..clear()
        ..addAll(fetchedData.data.items.map((item) => ChartMetricsModel.fromJson(item.toJson())));

      if (_allData.isNotEmpty) {
        _firstDataDate = _allData.first.date;
      }

      _processChartData();
      _error = null;
    } catch (e) {
      _error = 'Failed to load data: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _processChartData() {
    _allData.sort((a, b) => a.date.compareTo(b.date));

    final DateTimeRange range = dateRange;
    _filteredByRangeChartData
      ..clear()
      ..addAll(
        List.generate(
          range.duration.inDays + 1,
          (index) {
            final date = range.start.add(Duration(days: index));
            return _allData
                .firstWhere(
                  (m) => isSameDay(m.date, date),
                  orElse: () => ChartMetricsModel(
                    date: date,
                    spend: 0,
                    cpm: 0,
                    reach: 0,
                  ),
                )
                .copyWith(
                  spend: roundValue(
                    _allData
                        .firstWhere(
                          (m) => isSameDay(m.date, date),
                          orElse: () => ChartMetricsModel(date: date, spend: 0, cpm: 0, reach: 0),
                        )
                        .spend,
                    'spend',
                  ),
                  cpm: roundValue(
                    _allData
                        .firstWhere(
                          (m) => isSameDay(m.date, date),
                          orElse: () => ChartMetricsModel(date: date, spend: 0, cpm: 0, reach: 0),
                        )
                        .cpm,
                    'cpm',
                  ),
                );
          },
        ),
      );

    _updateDisplayDates();
    _updateMinMaxMetricValues();
  }

  bool isSameDay(DateTime date1, DateTime date2) =>
      date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;

  void _updateDisplayDates() {
    if (_filteredByRangeChartData.isEmpty) {
      _firstDate = _middleDate = _lastDate = null;
    } else {
      _firstDate = _displayDateFormat.format(_filteredByRangeChartData.first.date).toUpperCase();

      final middleIndex = _filteredByRangeChartData.length ~/ 2;
      _middleDate = _selectedPeriod.label == '24H' ? null : _displayDateFormat.format(_filteredByRangeChartData[middleIndex].date).toUpperCase();

      _lastDate = _displayDateFormat.format(_filteredByRangeChartData.last.date).toUpperCase();
    }
  }

  void _updateMinMaxMetricValues() {
    if (_filteredByRangeChartData.isEmpty) {
    } else {
      final values = _filteredByRangeChartData.map((item) => item.getMetricValue(_selectedMetricType));
      _maxMetricValue = formatMetricValue(values.reduce(max), _selectedMetricType);
    }
  }

  void selectMetricType(String metricType) {
    if (_selectedMetricType != metricType) {
      _selectedMetricType = metricType;
      _updateMinMaxMetricValues();
      notifyListeners();
    }
  }

  void selectPeriod(PeriodType period) {
    if (_selectedPeriod != period) {
      _selectedPeriod = period;
      _processChartData();
      notifyListeners();
    }
  }

  void updateCustomDateRange(DateTimeRange newRange) {
    _customDateRange = newRange;
    _selectedPeriod = PeriodType.custom;
    _processChartData();
    notifyListeners();
  }

  String getFormattedTotalValue() {
    final double total =
        _filteredByRangeChartData.fold(0.0, (sum, item) => sum + item.getMetricValue(_selectedMetricType));
    return formatMetricValue(total, _selectedMetricType);
  }

  void updatePointerValue(int index) {
    _pointerTimer?.cancel();

    if (index >= 0 && index < _filteredByRangeChartData.length) {
      final item = _filteredByRangeChartData[index];
      final value = item.getMetricValue(_selectedMetricType);
      final formattedValue = formatMetricValue(value, _selectedMetricType);
      final formattedDate = _pointerDateFormat.format(item.date);

      if (_pointerValue != formattedValue || _pointerDate != formattedDate) {
        _pointerValue = formattedValue;
        _pointerDate = formattedDate;
        notifyListeners();
      }
    }

    _pointerTimer = Timer(_pointerTimerDuration, clearPointerValue);
  }

  void clearPointerValue() {
    _pointerTimer?.cancel();
    _pointerTimer = null;

    if (_pointerValue != null || _pointerDate != null) {
      _pointerValue = _pointerDate = null;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _pointerTimer?.cancel();
    super.dispose();
  }
}
