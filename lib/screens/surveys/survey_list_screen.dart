import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/providers/survey/survey_provider.dart';
import 'package:quickyshop/utils/Colors.dart';
import 'package:quickyshop/widgets/app/goBackButton.dart';
import 'package:quickyshop/widgets/surveys/survey_card.dart';

class SurveyListScreen extends StatefulWidget {
  const SurveyListScreen({super.key});

  @override
  State<SurveyListScreen> createState() => _SurveyListScreenState();
}

class _SurveyListScreenState extends State<SurveyListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SurveyProvider>(context, listen: false).getAll();
    }); // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 70, bottom: 20, left: 20, right: 20),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Encuestas',
                      style: TextStyle(fontSize: 25),
                    ),
                    SecondaryGoBackButton()
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(child:
                  Consumer<SurveyProvider>(builder: (context, data, child) {
                return data.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: QuickyColors.primaryColor,
                        ),
                      )
                    : data.surveys.isEmpty
                        ? Center(
                            child: Text('No hay datos'),
                          )
                        : Column(
                            children: data.surveys
                                .map((e) => SurveyCard(survey: e))
                                .toList(),
                          );
              }))
            ],
          ),
        ),
      ),
    );
  }
}
