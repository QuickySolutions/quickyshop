import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/providers/statistics/statisticsProvider.dart';
import 'package:quickyshop/services/statisticsService.dart';
import 'package:quickyshop/utils/Colors.dart';
import 'package:quickyshop/widgets/charts/pie_chart.dart';

class SurveyStatistic extends StatefulWidget {
  const SurveyStatistic({super.key});

  @override
  State<SurveyStatistic> createState() => _SurveyStatisticState();
}

class _SurveyStatisticState extends State<SurveyStatistic> {
  StatisticService _statisticService = StatisticService();

  List<PieChartSectionData> pieChartData = [
    PieChartSectionData(
      color: Colors.blue,
      value: 25,
      title: '25%',
      radius: 50,
    ),
    PieChartSectionData(
      color: Colors.red,
      value: 50,
      title: '50%',
      radius: 50,
    ),
    PieChartSectionData(
      color: Colors.green,
      value: 25,
      title: '25%',
      radius: 50,
    ),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final statisticProvider = Provider.of<StatisticProvider>(context);
    return Scaffold(
        body: Container(
            padding: EdgeInsets.only(
              top: 70,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Mis',
                            style: TextStyle(
                                fontSize: 25,
                                color: QuickyColors.disableColor,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Estadisticas',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image(
                            height: 60,
                            image: AssetImage('assets/images/go-back.png')),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(child: Consumer<StatisticProvider>(
                    builder: (context, data, child) {
                  return FutureBuilder(
                    future: _statisticService.getSurveyQuestionsStatistics(
                        statisticProvider.surveyId),
                    builder: (context,
                        AsyncSnapshot<Map<String, dynamic>> snapshot) {
                      if (snapshot.hasData) {
                        String surveyName = snapshot.data!['survey']['name'];

                        int totalResponses =
                            snapshot.data!['survey']['numberResponses'];

                        List<dynamic> questions = snapshot.data!['questions'];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$surveyName',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 10),
                                  RichText(
                                    text: TextSpan(
                                        text: 'Total de',
                                        style: TextStyle(
                                            color: QuickyColors.disableColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: ' $totalResponses ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          TextSpan(
                                              text: 'respuestas',
                                              style: TextStyle(
                                                  color:
                                                      QuickyColors.disableColor,
                                                  fontWeight: FontWeight.w600))
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.only(top: 20),
                                itemCount: questions.length,
                                itemBuilder: (context, index) {
                                  List<dynamic> data = (questions[index]['data']
                                          as List<dynamic>)
                                      .map((e) {
                                    return {
                                      'color': getRandomColor(),
                                      ...e,
                                    };
                                  }).toList();

                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/survey/stadistic/question',
                                          arguments: data);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          bottom: 20, left: 20, right: 20),
                                      padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 20,
                                          bottom: 20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ]),
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            questions[index]['question'],
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          PieChartWidget(data: data)
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  );
                }))
              ],
            )));
  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(128) + 250,
      random.nextInt(128) + 250,
      random.nextInt(128) + 250,
      1.0,
    );
  }
}
