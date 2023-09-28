import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/providers/statistics/statisticsProvider.dart';

class SurveyStatistic extends StatefulWidget {
  const SurveyStatistic({super.key});

  @override
  State<SurveyStatistic> createState() => _SurveyStatisticState();
}

class _SurveyStatisticState extends State<SurveyStatistic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.only(top: 70, left: 30, right: 30),
            child: Column(
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
                // Expanded(
                //     child: Consumer<StatisticProvider>(
                //         builder: (context, data, child) {

                //         }))
              ],
            )));
  }
}
