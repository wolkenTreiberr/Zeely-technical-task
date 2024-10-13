import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeely_technical_task/enums/metric_type_enum.dart';
import 'package:zeely_technical_task/styles/styles.dart';

import '../../presenters/home_provider.dart';
import 'widgets/date_picker.dart';
import 'widgets/metric_chart.dart';
import 'widgets/metric_counter.dart';
import 'widgets/metrics_tab_bar.dart';
import 'widgets/period_selector.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.white,
      body: SafeArea(
        bottom: false,
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Consumer<HomeProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: constraints.maxHeight * 0.1,
                      bottom: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MetricTypeSection(
                          tabs: [MetricType.clicks.label, MetricType.spent.label, MetricType.costPerMille.label],
                          onTabSelected: (index) {
                            provider.selectMetricType(
                              [MetricType.clicks.name, MetricType.spent.name, MetricType.costPerMille.name][index],
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: constraints.maxHeight * 0.03, left: 20, right: 20),
                          child: const MetricCounter(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: constraints.maxHeight * 0.03, left: 20, right: 20),
                          child: MetricChart(
                            data: provider.filteredByRangeChartData,
                            selectedMetric: provider.selectedMetricType,
                            onPointerChange: provider.updatePointerValue,
                            onPointerExit: provider.clearPointerValue,
                            daysRange: [provider.firstDate, provider.middleDate, provider.lastDate],
                            maxMetricValue: provider.maxMetricValue ?? '',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: constraints.maxHeight * 0.025, left: 20, right: 20),
                          child: PeriodSelector(
                            periods: provider.availablePeriods,
                            selectedPeriod: provider.selectedPeriod,
                            onPeriodSelected: provider.selectPeriod,
                            onCustomRangeSelected: () => _showDateRangePicker(context, provider),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _showDateRangePicker(BuildContext context, HomeProvider provider) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colors.grey3,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (_, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 40 + MediaQuery.of(context).viewInsets.bottom,
                ),
                child: DatePicker(
                  initialDateRange: provider.dateRange,
                  onApply: provider.updateCustomDateRange,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
