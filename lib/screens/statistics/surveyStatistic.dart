import 'dart:developer';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/providers/statistics/statisticsProvider.dart';
import 'package:quickyshop/services/statisticsService.dart';
import 'package:quickyshop/utils/Colors.dart';
import 'package:quickyshop/utils/general_methods.dart';
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
            padding: EdgeInsets.only(top: 70, left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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

                        int numberOfPeople = totalResponses;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$surveyName',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
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
                                            color: QuickyColors.disableColor,
                                            fontWeight: FontWeight.w600))
                                  ]),
                            ),
                            SizedBox(height: 20),
                            Expanded(
                              child: ListView.builder(
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
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20),
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
                                          // Column(
                                          //   children: data.map((e) {
                                          //     print((e['count'] / data.length) *
                                          //         100);
                                          //     return Container(
                                          //       width: double.infinity,
                                          //       margin: EdgeInsets.symmetric(
                                          //           vertical: 10),
                                          //       child: Column(
                                          //         crossAxisAlignment:
                                          //             CrossAxisAlignment.start,
                                          //         children: [
                                          //           Text(
                                          //               'Respuesta No. ${data.indexOf(e) + 1}. Contestada: ${e['count']}'),
                                          //           SizedBox(height: 20),
                                          //           LinearProgressIndicator(
                                          //             valueColor:
                                          //                 AlwaysStoppedAnimation<
                                          //                     Color>(Colors.red),
                                          //             backgroundColor:
                                          //                 QuickyColors.greyColor,
                                          //             value: (e['count'] /
                                          //                 data.length),
                                          //           )
                                          //         ],
                                          //       ),
                                          //     );
                                          //     //return Container();
                                          //   }).toList(),
                                          // ),

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
