// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:zeely_technical_task/styles/styles.dart';

class MetricTypeSection extends StatefulWidget {
  const MetricTypeSection({
    super.key,
    required this.tabs,
    required this.onTabSelected,
    this.initialIndex = 0,
  });

  final List<String> tabs;
  final ValueChanged<int> onTabSelected;
  final int initialIndex;

  @override
  _MetricTypeSectionState createState() => _MetricTypeSectionState();
}

class _MetricTypeSectionState extends State<MetricTypeSection> {
  late PageController _pageController;
  late int _selectedIndex;

  static const double _tabHeight = 37.0;
  static const double _tabViewportFraction = 0.3;
  static const Duration _animationDuration = Duration(milliseconds: 300);
  static const Curve _animationCurve = Curves.easeInOut;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _pageController = PageController(
      viewportFraction: _tabViewportFraction,
      initialPage: _selectedIndex,
    );
  }

  void _onTabTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      _pageController.animateToPage(
        index,
        duration: _animationDuration,
        curve: _animationCurve,
      );
      widget.onTabSelected(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final TextTheme textStyles = context.textStyles;

    return SizedBox(
      height: _tabHeight,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.tabs.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildTab(index, colors, textStyles),
      ),
    );
  }

  Widget _buildTab(int index, AppColors colors, TextTheme textStyles) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: AnimatedContainer(
        duration: _animationDuration,
        margin: const EdgeInsets.symmetric(horizontal: 2.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: isSelected ? colors.black : colors.grey1),
        ),
        child: Center(
          child: Text(
            widget.tabs[index],
            style: textStyles.metricTabName,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
