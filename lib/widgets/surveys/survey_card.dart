import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/models/survey/Survey.dart';
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
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 130,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
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
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg?cs=srgb&dl=pexels-pixabay-268533.jpg&fm=jpg'),
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
                            Text(
                              'Titulo ejemplo',
                              style: TextStyle(
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Vence: 22/03/2001',
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(height: 12),
                            SwitchControl(
                              value: true,
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
