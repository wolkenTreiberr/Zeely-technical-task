enum PeriodType {
  all,
  last24Hours,
  last7Days,
  lastMonth,
  last3Months,
  last6Months,
  custom;

  String get label => switch (this) {
        all => 'ALL',
        last24Hours => '24H',
        last7Days => '7D',
        lastMonth => '1M',
        last3Months => '3M',
        last6Months => '6M',
        custom => 'SET'
      };
}
