import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/models/survey/Survey.dart';
import 'package:quickyshop/providers/survey/survey_provider.dart';
import 'package:quickyshop/utils/survey_utils.dart';
import 'package:quickyshop/widgets/app/goBackButton.dart';
import 'package:quickyshop/utils/Colors.dart';
import 'package:quickyshop/widgets/buttons/quickyButton.dart';
import 'package:quickyshop/widgets/inputs/quicky_textfield.dart';

class CreateSurveyScreen extends StatelessWidget {
  CreateSurveyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final surveyProvider = Provider.of<SurveyProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                backgroundSurvey(surveyProvider),
                principalFormSurvey(context, surveyProvider),
                SizedBox(height: 20),
                buttonsSurveys(context, surveyProvider)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_getFromGallery(SurveyProvider surveyProvider) async {
  PickedFile? pickedFile = await ImagePicker().getImage(
    source: ImageSource.gallery,
    maxWidth: 1800,
    maxHeight: 1800,
  );
  if (pickedFile != null) {
    File imageFile = File(pickedFile.path);
    surveyProvider.selectPicture(imageFile);
  }
}

Widget backgroundSurvey(SurveyProvider surveyProvider) {
  return Container(
    decoration: BoxDecoration(
        color: Color(0xff9C9FA0),
        image: DecorationImage(
          image: FileImage(surveyProvider.selectedPhoto),
          fit: BoxFit.cover,
        )),
    width: double.infinity,
    height: 180,
    child: Stack(
      children: [
        Positioned(
          top: 20,
          right: 20,
          child: GoBackButton(),
        ),
        Positioned(
          left: 40,
          bottom: 20,
          child: GestureDetector(
            onTap: () {
              _getFromGallery(surveyProvider);
            },
            child: Container(
              width: 170,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color.fromARGB(255, 210, 206, 206)),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: QuickyColors.primaryColor,
                    radius: 25,
                    child: Image(
                        height: 20,
                        image: AssetImage(
                            'assets/icons/usability/edit_white.png')),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text('Añadir foto')
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget principalFormSurvey(
  BuildContext context,
  SurveyProvider surveyProvider,
) {
  return Container(
    padding: EdgeInsets.only(top: 30, bottom: 10, left: 30, right: 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nombre de la encuesta:'),
        SizedBox(height: 15),
        QuickyTextField(
          defaultValue: surveyProvider.surveyAction == SurveyAction.create
              ? ''
              : surveyProvider.surveyName,
          onChanged: (String value) {
            surveyProvider.onChangeName(value);
          },
        ),
        SizedBox(height: 15),
        Text('Descripción (opcional)'),
        SizedBox(height: 15),
        QuickyTextArea(
          defaultValue: surveyProvider.surveyAction == SurveyAction.create
              ? ''
              : surveyProvider.surveyDescription,
          maxLines: 5,
          onChanged: (String value) {
            surveyProvider.onChangeDescription(value);
          },
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Fecha de inicio:'),
                SizedBox(height: 20),
                Container(
                    width: 150,
                    child: QuickyTextField(
                      controller: surveyProvider.initDateController,
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100));
                        var date = DateTime.parse(pickedDate.toString());

                        var formattedDate =
                            "${date.year}-${date.month}-${date.day}";
                        surveyProvider.onChangeInitDate(formattedDate);
                        surveyProvider.initDateController.text = formattedDate;
                      },
                      isDate: true,
                    ))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Fecha de fin:'),
                SizedBox(height: 20),
                Container(
                    width: 150,
                    child: QuickyTextField(
                      controller: surveyProvider.finalDateController,
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100));
                        var date = DateTime.parse(pickedDate.toString());

                        var formattedDate =
                            "${date.year}-${date.month}-${date.day}";
                        surveyProvider.onChangeFinalDate(formattedDate);
                        surveyProvider.finalDateController.text = formattedDate;
                      },
                      isDate: true,
                    ))
              ],
            ),
          ],
        )
      ],
    ),
  );
}

Widget buttonsSurveys(BuildContext context, SurveyProvider surveyProvider) {
  return Container(
    alignment: Alignment.center,
    child: Column(
      children: [
        QuickyButton(
          type: QuickyButtonTypes.tertiary,
          onTap: () {
            print('hi');
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '+',
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 10),
              Text(
                'Crear un cupón',
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        SizedBox(height: 10),
        QuickyButton(
            type: QuickyButtonTypes.secondary,
            onTap: () {
              print('hi');
            },
            child: Text(
              'Escoge un cupón guardado',
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            )),
        SizedBox(height: 10),
        QuickyButton(
            type: QuickyButtonTypes.primary,
            onTap: () {
              if (surveyProvider.surveyAction == SurveyAction.create) {
                Survey survey = Survey(
                    id: '',
                    name: surveyProvider.surveyName,
                    questions: [],
                    description: surveyProvider.surveyDescription,
                    photo: '',
                    secretPassword: '1334444',
                    initDate: surveyProvider.initDate,
                    finalDate: surveyProvider.finalDate);

                surveyProvider.addSurvey(survey);
              } else {
                Survey survey = Survey(
                    id: surveyProvider.survey.id,
                    name: surveyProvider.surveyName,
                    questions: surveyProvider.survey.questions,
                    description: surveyProvider.surveyDescription,
                    secretPassword: '1334444',
                    initDate: surveyProvider.initDate,
                    finalDate: surveyProvider.finalDate);

                surveyProvider.addSurvey(survey);
              }
              Navigator.pushNamed(context, '/create/survey/questions');
            },
            child: Text(
              'Continuar',
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ))
      ],
    ),
  );
}
