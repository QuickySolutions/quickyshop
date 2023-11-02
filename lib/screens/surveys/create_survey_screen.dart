import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/models/Coupon.dart';
import 'package:quickyshop/models/survey/Survey.dart';
import 'package:quickyshop/providers/app/appProvider.dart';
import 'package:quickyshop/providers/coupons/coupon_provider.dart';
import 'package:quickyshop/providers/survey/survey_provider.dart';
import 'package:quickyshop/screens/surveys/create_survey_questions_screen.dart';
import 'package:quickyshop/screens/surveys/store_selection_screen.dart';
import 'package:quickyshop/utils/survey_utils.dart';
import 'package:quickyshop/widgets/app/goBackButton.dart';
import 'package:quickyshop/utils/Colors.dart';
import 'package:quickyshop/widgets/buttons/quickyButton.dart';
import 'package:quickyshop/widgets/dialogs/QuickyAlertDialog.dart';
import 'package:quickyshop/widgets/dialogs/coupons/add.dart';
import 'package:quickyshop/widgets/dialogs/coupons/list_coupons.dart';
import 'package:quickyshop/widgets/inputs/quicky_textfield.dart';
import 'package:uuid/uuid.dart';

class CreateSurveyScreen extends StatelessWidget {
  final List<Widget> pages = [
    FormSurveyScreen(),
    StoreSelectionScreen(),
    CreateSurveyQuestionsScreen()
  ];
  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<SurveyProvider>(
        builder: (context, value, child) {
          return SafeArea(
            child: Container(
              height: heightScreen,
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(bottom: 5),
                    child: PageView.builder(
                      controller: value.pageController,
                      onPageChanged: (int page) {
                        value.setPage(page);
                      },
                      itemCount: pages.length,
                      itemBuilder: (context, index) {
                        return pages[index];
                      },
                    ),
                  )),
                  Container(
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
    return Container(
      height: 10,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 10 : 8.0,
        width: isActive ? 12 : 8.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? Color(0XFF6BC4C9) : Color(0XFFEAEAEA),
        ),
      ),
    );
  }
}

class FormSurveyScreen extends StatelessWidget {
  FormSurveyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final surveyProvider = Provider.of<SurveyProvider>(context);
    final couponProvider = Provider.of<CouponProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            backgroundSurvey(surveyProvider, context),
            principalFormSurvey(context, surveyProvider),
            SizedBox(height: 10),
            buttonsSurveys(context, surveyProvider, couponProvider, appProvider)
          ],
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

BoxDecoration setContainerBackground(SurveyProvider surveyProvider) {
  bool userHasSelectImage = surveyProvider.selectedPhoto.path.isNotEmpty;
  bool surveyHasNoPhoto = surveyProvider.survey.photo == "";

  if (surveyProvider.surveyAction == SurveyAction.edit) {
    if (surveyHasNoPhoto && !userHasSelectImage) {
      return BoxDecoration(
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
        color: Color(0xff9C9FA0),
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
          type: QuickyButtonTypes.tertiary,
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return QuickyAlertDialog(
                    childContent: AddCouponForm(),
                    showNextButton: true,
                    onNextClick: () {
                      if (couponProvider.isValidForm) {
                        Coupon couponItem = Coupon(
                            id: Uuid().v4(),
                            active: true,
                            brandId: appProvider.brandDefault.id,
                            name: couponProvider.couponName,
                            monetization: couponProvider.couponMonetization);
                        couponProvider.resetSelectedCoupon();
                        couponProvider.addCoupon(couponItem);

                        Navigator.pop(context);
                      } else {
                        const snackBar = SnackBar(
                          content: Text('Rellena los datos'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  );
                });
          },
          child: couponProvider.getCreatedCoupon().id!.isNotEmpty
              ? Text(
                  couponProvider.getCreatedCoupon().name,
                  style: TextStyle(color: Colors.black),
                )
              : Row(
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
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return QuickyAlertDialog(
                        childContent: Column(
                      children: [Expanded(child: CouponList())],
                    ));
                  });
            },
            // child: couponProvider.areCouponSelectedOrCreated
            //     ? Text(couponProvider.getCoupon.name)
            //     : Text(
            //         'Escoge un cupón guardado',
            //         style: TextStyle(
            //             fontSize: 17,
            //             color: Colors.white,
            //             fontWeight: FontWeight.w500),
            //       )),

            child: Text(
              couponProvider.getSelectedCoupon().id!.isNotEmpty
                  ? couponProvider.getSelectedCoupon().name
                  : 'Escoge un cupón guardado',
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            )),
        SizedBox(height: 10),
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
