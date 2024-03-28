import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/models/survey/Survey.dart';
import 'package:quickyshop/providers/app/appProvider.dart';
import 'package:quickyshop/providers/coupons/coupon_provider.dart';
import 'package:quickyshop/providers/store/store_provider.dart';
import 'package:quickyshop/providers/survey/survey_provider.dart';
import 'package:quickyshop/screens/surveys/create_survey_questions_screen.dart';
import 'package:quickyshop/screens/surveys/cupon_selection_screen.dart';
import 'package:quickyshop/screens/surveys/store_selection_screen.dart';
import 'package:quickyshop/utils/survey_utils.dart';
import 'package:quickyshop/widgets/app/goBackButton.dart';
import 'package:quickyshop/utils/Colors.dart';
import 'package:quickyshop/widgets/buttons/quickyButton.dart';
import 'package:quickyshop/widgets/inputs/quicky_textfield.dart';

class CreateSurveyScreen extends StatelessWidget {
  final List<Widget> pages = [
    const FormSurveyScreen(),
    const StoreSelectionScreen(),
    const CouponSelectScreen(),
    CreateSurveyQuestionsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final surveyProvider = Provider.of<SurveyProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<SurveyProvider>(
        builder: (context, value, child) {
          return SafeArea(
            child: SizedBox(
              height: heightScreen,
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: PageView.builder(
                      controller: value.pageController,
                      physics:
                          surveyProvider.surveyAction == SurveyAction.create
                              ? const NeverScrollableScrollPhysics()
                              : const ScrollPhysics(),
                      onPageChanged: (int page) {
                        value.setPage(page);
                      },
                      itemCount: pages.length,
                      itemBuilder: (context, index) {
                        return pages[index];
                      },
                    ),
                  )),
                  SizedBox(
                    height: heightScreen * 0.04,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(value),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildPageIndicator(SurveyProvider surveyProvider) {
    List<Widget> list = [];
    for (int i = 0; i < pages.length; i++) {
      list.add(i == surveyProvider.activePage
          ? _indicator(true)
          : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return SizedBox(
      height: 10,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 10 : 8.0,
        width: isActive ? 12 : 8.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? const Color(0XFF6BC4C9) : const Color(0XFFEAEAEA),
        ),
      ),
    );
  }
}

class FormSurveyScreen extends StatelessWidget {
  const FormSurveyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final surveyProvider = Provider.of<SurveyProvider>(context);
    final couponProvider = Provider.of<CouponProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          backgroundSurvey(surveyProvider, context),
          principalFormSurvey(context, surveyProvider),
          const SizedBox(height: 10),
          buttonsSurveys(context, surveyProvider, couponProvider, appProvider)
        ],
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

BoxDecoration setContainerBackground(SurveyProvider surveyProvider) {
  bool userHasSelectImage = surveyProvider.selectedPhoto.path.isNotEmpty;
  bool surveyHasNoPhoto = surveyProvider.survey.photo == "";

  if (surveyProvider.surveyAction == SurveyAction.edit) {
    if (surveyHasNoPhoto && !userHasSelectImage) {
      return const BoxDecoration(
        color: Color(0xff9C9FA0),
      );
    } else {
      return BoxDecoration(
          image: userHasSelectImage
              ? DecorationImage(
                  image: FileImage(surveyProvider.selectedPhoto),
                  fit: BoxFit.cover)
              : DecorationImage(
                  image: NetworkImage(surveyProvider.survey.photo!),
                  fit: BoxFit.cover));
    }
  } else {
    return BoxDecoration(
        color: const Color(0xff9C9FA0),
        image: userHasSelectImage
            ? DecorationImage(
                image: FileImage(surveyProvider.selectedPhoto),
                fit: BoxFit.cover,
              )
            : null);
  }
}

Widget backgroundSurvey(SurveyProvider surveyProvider, BuildContext context) {
  return Container(
    decoration: setContainerBackground(surveyProvider),
    width: double.infinity,
    height: 180,
    child: Stack(
      children: [
        Positioned(
          top: 20,
          right: 20,
          child: GoBackButton(
            onTap: () {
              surveyProvider.reset();
              Navigator.pop(context, true);
            },
          ),
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
                    child: const Image(
                        height: 20,
                        image: AssetImage(
                            'assets/icons/usability/edit_white.png')),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text('Añadir foto')
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
        const Text('Nombre de la encuesta:'),
        const SizedBox(height: 15),
        QuickyTextField(
          keyboardType: TextInputType.name,
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
          maxLines: 4,
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

                        if (pickedDate != null) {
                          var formattedDate =
                              "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

                          surveyProvider.onChangeInitDate(formattedDate);
                          surveyProvider.initDateController.text =
                              formattedDate;
                        }
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

                        if (pickedDate != null) {
                          var formattedDate =
                              "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

                          surveyProvider.onChangeFinalDate(formattedDate);
                          surveyProvider.finalDateController.text =
                              formattedDate;
                        }
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

Widget buttonsSurveys(BuildContext context, SurveyProvider surveyProvider,
    CouponProvider couponProvider, AppProvider appProvider) {
  return Container(
    alignment: Alignment.center,
    child: Column(
      children: [
        QuickyButton(
            disabled: !surveyProvider.isValidForm,
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
                    photo: surveyProvider.survey.photo,
                    questions: surveyProvider.survey.questions!.map((e) {
                      e.isNew = false;
                      return e;
                    }).toList(),
                    stores: surveyProvider.survey.stores,
                    description: surveyProvider.surveyDescription,
                    secretPassword: '1334444',
                    initDate: surveyProvider.initDate,
                    finalDate: surveyProvider.finalDate);

                surveyProvider.addSurvey(survey);
              }
              surveyProvider.changePage();
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
