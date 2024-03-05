import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:quickyshop/utils/Colors.dart';

class BarChartWidget extends StatelessWidget {
  final List<dynamic> data;
  const BarChartWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: BarChart(
        BarChartData(
            barTouchData: barTouchData,
            titlesData: titlesData,
            borderData: borderData,
            barGroups: barGroups,
            gridData: const FlGridData(show: false),
            alignment: BarChartAlignment.spaceAround,
            maxY: 10),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  FlTitlesData get titlesData => const FlTitlesData(
        show: true,
        leftTitles: AxisTitles(
          sideTitles:
              SideTitles(showTitles: true, reservedSize: 40, interval: 2),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  List<BarChartGroupData> get barGroups => data.map((e) {
        return BarChartGroupData(
          x: 50,
          barRods: [
            BarChartRodData(
              toY: (e['count'] as int).toDouble(),
              gradient: LinearGradient(
                colors: [QuickyColors.greyColor, e['color']],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            )
          ],
          showingTooltipIndicators: [0],
        );
      }).toList();
}
