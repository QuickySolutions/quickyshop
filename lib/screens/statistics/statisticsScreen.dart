import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/models/survey/Survey.dart';
import 'package:quickyshop/providers/app/appProvider.dart';
import 'package:quickyshop/providers/statistics/statisticsProvider.dart';
import 'package:quickyshop/services/statisticsService.dart';
import 'package:quickyshop/services/surveyService.dart';
import 'package:quickyshop/widgets/app/chipItem.dart';
import 'package:quickyshop/widgets/app/customSwitch.dart';

class StatisticsScreen extends StatefulWidget {
  StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  final SurveyService _surveyService = SurveyService();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appProvider = Provider.of<AppProvider>(context, listen: false);
      if (appProvider.hasSelectedBrand) {
        Provider.of<StatisticProvider>(context, listen: false)
            .getAll(appProvider.brandDefault.id);
      } else {
        Provider.of<StatisticProvider>(context, listen: false)
            .getStoreSurveys(appProvider.storeSelected.id!);
      }
    });
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
            Expanded(child:
                Consumer<StatisticProvider>(builder: (context, data, child) {
              return data.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(children: [
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                child: ChipItem(
                                    text:
                                        'Encuestas creadas: ${data.surveys.length}'),
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Container(
                                child: ChipItem(text: 'Cupones canjeados: 0'),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                          child: GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                mainAxisExtent: 170),
                        itemCount: data.surveys.length,
                        itemBuilder: (BuildContext context, int index) {
                          Survey survey = data.surveys[index];
                          return GestureDetector(
                            onTap: () {
                              statisticProvider.setSurveyId(survey.id!);
                              Navigator.pushNamed(
                                context,
                                '/survey/stadistic',
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(survey.name,
                                        overflow: TextOverflow.ellipsis),
                                    SizedBox(height: 10),
                                    Text("Vence: ${survey.finalDate}"),
                                    SizedBox(height: 10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SwitchControl(
                                          value: survey.active,
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                            '${survey.active ? "Activa" : "No Activa"}')
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ))
                    ]);
            }))
          ],
        ),
      ),
    );
  }
}
