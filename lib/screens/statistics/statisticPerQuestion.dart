import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:quickyshop/widgets/charts/bar_chart.dart';
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
                  BarChartWidget(data: questions)
                ],
              ),
            ),
            Column(
              children: questions
                  .map((e) => Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: e['color'],
                                        borderRadius: BorderRadius.circular(5)),
                                    height: 50,
                                    width: 50,
                                    alignment: Alignment.center,
                                    child: Text(
                                      questions.indexOf(e).toString(),
                                      style: TextStyle(color: Colors.white),
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  e['titleOptionSurvey'],
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Text('Veces seleccionada ${e['count']}',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.withOpacity(0.9)))
                          ],
                        ),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
