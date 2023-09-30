import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/providers/statistics/statisticsProvider.dart';
import 'package:quickyshop/services/statisticsService.dart';

class SurveyStatistic extends StatefulWidget {
  const SurveyStatistic({super.key});

  @override
  State<SurveyStatistic> createState() => _SurveyStatisticState();
}

class _SurveyStatisticState extends State<SurveyStatistic> {
  StatisticService _statisticService = StatisticService();
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
                          style: TextStyle(fontSize: 25),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Estadisticas',
                          style: TextStyle(fontSize: 25),
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
                            Text(
                              '$surveyName',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Total de respuestas: $totalResponses',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 20),
                            Column(
                                children: questions.map((e) {
                              List<dynamic> data = e['data'];
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(e['question']),
                                    SizedBox(height: 20),
                                    Column(
                                      children: data
                                          .map((e) => Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                child: Text(
                                                    'Respuesta No. ${data.indexOf(e) + 1}. Contestada: ${e['count']}'),
                                              ))
                                          .toList(),
                                    )
                                  ],
                                ),
                              );
                            }).toList())
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
}
