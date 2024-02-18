import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/models/survey/Survey.dart';
import 'package:quickyshop/providers/store/store_provider.dart';
import 'package:quickyshop/providers/survey/survey_provider.dart';
import 'package:quickyshop/utils/Colors.dart';
import 'package:quickyshop/widgets/app/customSwitch.dart';

class SurveyCard extends StatefulWidget {
  Survey survey;

  SurveyCard({required this.survey});

  @override
  State<SurveyCard> createState() => _SurveyCardState();
}

class _SurveyCardState extends State<SurveyCard> {
  bool wantToSeeOptions = false;
  @override
  Widget build(BuildContext context) {
    final surveyProvider = Provider.of<SurveyProvider>(context);
    final storeProvider = Provider.of<StoreProvider>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 140,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
          color: Colors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: 100,
              height: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10)),
                child: widget.survey.photo!.isEmpty
                    ? Image(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/not-available.png'))
                    : Image(
                        errorBuilder: (context, error, stackTrace) {
                          return Image(
                              image: AssetImage(
                                  'assets/images/not-available.png'));
                        },
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.survey.photo!),
                      ),
              )),
          SizedBox(width: 8),
          Expanded(
            child: wantToSeeOptions
                ? Container(
                    padding: EdgeInsets.only(right: 30),
                    color: QuickyColors.greyColor,
                    height: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                storeProvider
                                    .setSelectedStores(widget.survey.stores!);
                                surveyProvider.setPage(0);
                                surveyProvider.setSurvey(widget.survey);
                                Navigator.pushNamed(context, '/create/survey');
                              },
                              child: CircleAvatar(
                                backgroundColor: QuickyColors.primaryColor,
                                radius: 30,
                                child: Image(
                                    height: 30,
                                    image: AssetImage(
                                        'assets/icons/usability/edit_button_icon.png')),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text('Editar')
                          ],
                        ),
                        SizedBox(width: 30),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              wantToSeeOptions = !wantToSeeOptions;
                            });
                          },
                          child: Image(
                              height: 40,
                              image: AssetImage(
                                  'assets/icons/usability/options.png')),
                        )
                      ],
                    ),
                  )
                : Container(
                    padding: EdgeInsets.only(
                        bottom: 20, top: 20, left: 20, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Text(
                                widget.survey.name,
                                style: TextStyle(
                                    fontSize: 18,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Vence: ${widget.survey.finalDate}',
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(height: 12),
                            SwitchControl(
                              value: widget.survey.active,
                              onChanged: (value) {
                                print(value);
                              },
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              wantToSeeOptions = !wantToSeeOptions;
                            });
                          },
                          child: Image(
                              height: 40,
                              image: AssetImage(
                                  'assets/icons/usability/options.png')),
                        )
                      ],
                    )),
          ),
        ],
      ),
    );
  }
}
