import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:quickyshop/widgets/charts/pie_chart.dart';

class QuestionStatistics extends StatefulWidget {
  const QuestionStatistics({super.key});

  @override
  State<QuestionStatistics> createState() => _QuestionStatisticsState();
}

class _QuestionStatisticsState extends State<QuestionStatistics> {
  @override
  Widget build(BuildContext context) {
    final questions =
        ModalRoute.of(context)?.settings.arguments as List<dynamic>;
    inspect(questions);
    return Scaffold(
      appBar: AppBar(
        title: Text('Estadistica por pregunta'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: PageView(
                children: [
                  PieChartWidget(
                    data: questions,
                  ),
                  PieChartWidget(
                    data: questions,
                  )
                ],
              ),
            ),
            Column(
              children: questions
                  .map((e) => ListTile(
                        title: Text(e['titleOptionSurvey']),
                        subtitle: Text('No. veces seleccionada ${e['count']}'),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  // Widget changeBar() {}

  // Widget showBar() {}
}
