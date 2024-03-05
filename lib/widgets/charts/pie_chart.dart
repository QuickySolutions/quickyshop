import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartWidget extends StatelessWidget {
  final List<dynamic> data;

  PieChartWidget({required this.data});

  List<PieChartSectionData> getPieChartData() {
    return data.map((e) {
      return PieChartSectionData(
        titleStyle: const TextStyle(color: Colors.white),
        color: e['color'],
        value: (e['count'] as int).toDouble(),
        title:
            '${(((e['count'] as int).toDouble() / data.length) * 100).toInt().toString()}%',
        radius: 50,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    bool hasData = data.any((e) => (e['count'] as int) > 0);

    return Stack(
      alignment: Alignment.center,
      children: [
        if (hasData)
          AspectRatio(
            aspectRatio: 1.0,
            child: PieChart(
              PieChartData(
                sections: getPieChartData(),
                borderData: FlBorderData(show: false),
                sectionsSpace: 0,
                centerSpaceRadius: 40,
              ),
            ),
          )
        else
          Center(
            child: Text(
              'Sin respuestas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
      ],
    );
  }
}
