import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartWidget extends StatelessWidget {
  final List<dynamic> data;

  PieChartWidget({required this.data});

  List<PieChartSectionData> getPieChartData() {
    inspect(data);
    return data.map((e) {
      return PieChartSectionData(
        titleStyle: const TextStyle(color: Colors.white),
        color: e['color'],
        value: (e['count'] as int).toDouble(),
        title: e['titleOptionSurvey'],
        radius: 50,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: PieChart(
        PieChartData(
          sections: getPieChartData(),
          borderData: FlBorderData(show: false),
          sectionsSpace: 0,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }
}
