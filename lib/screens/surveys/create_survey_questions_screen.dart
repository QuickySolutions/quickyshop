import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/firebase/uploadFilesToFirebase.dart';
import 'package:quickyshop/models/survey/Question.dart';
import 'package:quickyshop/models/survey/questions/TemplateQuestion.dart';
import 'package:quickyshop/providers/app/appProvider.dart';
import 'package:quickyshop/providers/coupons/coupon_provider.dart';
import 'package:quickyshop/providers/store/store_provider.dart';
import 'package:quickyshop/providers/survey/survey_provider.dart';
import 'package:quickyshop/utils/survey_utils.dart';
import 'package:quickyshop/widgets/app/goBackButton.dart';
import 'package:quickyshop/services/surveyService.dart';
import 'package:quickyshop/utils/Colors.dart';
import 'package:quickyshop/widgets/buttons/quickyButton.dart';
import 'package:quickyshop/widgets/surveys/survey_question_item.dart';
import 'package:uuid/uuid.dart';

class CreateSurveyQuestionsScreen extends StatefulWidget {
  CreateSurveyQuestionsScreen({super.key});

  @override
  State<CreateSurveyQuestionsScreen> createState() =>
      _CreateSurveyQuestionsScreenState();
}

class _CreateSurveyQuestionsScreenState
    extends State<CreateSurveyQuestionsScreen>
    with SingleTickerProviderStateMixin {
  final SurveyService surveyService = SurveyService();

  UploadFilesToFirebase _uploadFilesToFirebase = UploadFilesToFirebase();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   final surveyProvider = Provider.of<SurveyProvider>(context);
  //   final storeProvider = Provider.of<StoreProvider>(context);
  //   final appProvider = Provider.of<AppProvider>(context);
  //   return Scaffold(
  //       floatingActionButton: GestureDetector(
  //         onTap: () {
  //           Question newQuestion = TemplateQuestion(
  //               isNew: true,
  //               id: Uuid().v4(),
  //               title: 'Pregunta...',
  //               type: 'normal') as Question;
  //           surveyProvider.addNewQuestion(newQuestion);
  //         },
  //         child: Image(
  //           height: 80,
  //           width: 80,
  //           image: AssetImage('assets/icons/usability/buttonplus.png'),
  //         ),
  //       ),
  //       backgroundColor: Color(0xffF4F4F4),
  //       body: SafeArea(
  //         child: Container(
  //           child: Column(
  //             children: [
  //               Expanded(
  //                 child: SingleChildScrollView(
  //                   child: Column(
  //                     children: [
  //                       Container(
  //                         padding: EdgeInsets.all(20),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Container(
  //                               alignment: Alignment.centerRight,
  //                               child: GoBackButton(
  //                                 onTap: () {
  //                                   surveyProvider.goBackPage();
  //                                 },
  //                               ),
  //                             ),
  //                             Container(
  //                               child: Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   Text('Preguntas',
  //                                       style: TextStyle(fontSize: 20)),
  //                                   SizedBox(height: 20),
  //                                   Text(
  //                                     'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismo.',
  //                                     style: TextStyle(
  //                                         color: QuickyColors.disableColor),
  //                                   )
  //                                 ],
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                       SizedBox(height: 30),
  //                       Column(
  //                         children: surveyProvider.survey.questions!
  //                             .map((Question question) {
  //                           int index = surveyProvider.survey.questions!
  //                               .indexWhere((el) => el.id == question.id);
  //                           return SurveyQuestionItem(
  //                             indexQuestion: index,
  //                             question: question,
  //                           );
  //                         }).toList(),
  //                       ),
  //                       SizedBox(height: 20),
  //                       QuickyButton(
  //                           disabled:
  //                               surveyProvider.survey.questions!.isEmpty ||
  //                                   surveyProvider.isLoadingCreateOrEditSurvey,
  //                           type: QuickyButtonTypes.finishSurvey,
  //                           child: Text('Finalizar'),
  //                           onTap: () async {
  //                             if (surveyProvider.surveyAction ==
  //                                 SurveyAction.create) {
  //                               if (surveyProvider.selectedPhoto.path.isEmpty) {
  //                                 surveyProvider
  //                                     .setLoadCreateOrEditSurvey(true);
  //                                 createSurvey(surveyProvider, storeProvider,
  //                                     appProvider, context);
  //                                 surveyProvider
  //                                     .setLoadCreateOrEditSurvey(false);
  //                                 Navigator.pushNamedAndRemoveUntil(
  //                                     context, '/base', (_) => false);
  //                               } else {
  //                                 String url = await _uploadFilesToFirebase
  //                                     .uploadSurveyPhoto(
  //                                         surveyProvider.selectedPhoto,
  //                                         'SURVEY_PHOTO_${Uuid().v4()}');
  //                                 surveyProvider.setPhoto(url);
  //                                 createSurvey(surveyProvider, storeProvider,
  //                                     appProvider, context);
  //                                 surveyProvider
  //                                     .setLoadCreateOrEditSurvey(false);
  //                                 Navigator.pushNamed(context, '/base');
  //                               }
  //                             } else {
  //                               if (surveyProvider
  //                                   .selectedPhoto.path.isNotEmpty) {
  //                                 surveyProvider
  //                                     .setLoadCreateOrEditSurvey(true);
  //                                 String url = await _uploadFilesToFirebase
  //                                     .uploadSurveyPhoto(
  //                                         surveyProvider.selectedPhoto,
  //                                         'SURVEY_PHOTO_${surveyProvider.survey.id}');
  //                                 surveyProvider.setPhoto(url);
  //                                 await surveyService.editSurvey(
  //                                     surveyProvider.survey, storeProvider);
  //                                 surveyProvider.reset();
  //                                 storeProvider.reset();
  //                                 surveyProvider
  //                                     .setLoadCreateOrEditSurvey(false);
  //                                 Navigator.pushNamedAndRemoveUntil(
  //                                     context, '/base', (_) => false);
  //                               } else {
  //                                 await surveyService.editSurvey(
  //                                     surveyProvider.survey, storeProvider);
  //                                 surveyProvider.reset();
  //                                 storeProvider.reset();
  //                                 Navigator.pushNamedAndRemoveUntil(
  //                                     context, '/base', (_) => false);
  //                               }
  //                             }
  //                           })
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       )
  //       //SafeArea(
  //       //   child: Container(
  //       //     child:
  //       // ),
  //       );
  // }
  @override
  Widget build(BuildContext context) {
    final surveyProvider = Provider.of<SurveyProvider>(context);
    final storeProvider = Provider.of<StoreProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    final couponProvider = Provider.of<CouponProvider>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0,
            backgroundColor: QuickyColors.greyColor,
            automaticallyImplyLeading: false,
            expandedHeight: 100.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                alignment: Alignment.bottomCenter,
                width: double.infinity,
                height: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text('Preguntas',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Question newQuestion = TemplateQuestion(
                                isNew: true,
                                id: const Uuid().v4(),
                                title: 'Pregunta...',
                                type: 'normal');
                            surveyProvider.addNewQuestion(newQuestion);
                          },
                          child: Container(
                            height: 32,
                            decoration: BoxDecoration(
                                color: QuickyColors.primaryColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50))),
                            width: 32,
                            alignment: Alignment.center,
                            child: const Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SizedBox(
                              width: 30,
                              child: GestureDetector(
                                onTap: () {
                                  surveyProvider.goBackPage();
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 30,
                                  child: Image(
                                    height: 20,
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/icons/usability/backIcon.png'),
                                  ),
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: surveyProvider.survey.questions!.length,
              (BuildContext context, int index) {
                Question question = surveyProvider.survey.questions![index];
                return SurveyQuestionItem(
                  indexQuestion: index,
                  question: question,
                );
                // Column(
                //   children: surveyProvider.survey.questions!
                //       .map((Question question) {
                //     int index = surveyProvider.survey.questions!
                //         .indexWhere((el) => el.id == question.id);

                //   }).toList(),
                // ),

                // Aquí puedes agregar tu contenido de lista
                // return Container(
                //   child: SingleChildScrollView(
                //     child: Column(
                //       children: [

                //         SizedBox(height: 20),
                //         QuickyButton(
                //             disabled:
                //                 surveyProvider.survey.questions!.isEmpty ||
                //                     surveyProvider.isLoadingCreateOrEditSurvey,
                //             type: QuickyButtonTypes.finishSurvey,
                //             child: Text('Finalizar'),
                //             onTap: () async {
                //               if (surveyProvider.surveyAction ==
                //                   SurveyAction.create) {
                //                 if (surveyProvider.selectedPhoto.path.isEmpty) {
                //                   surveyProvider
                //                       .setLoadCreateOrEditSurvey(true);
                //                   createSurvey(surveyProvider, storeProvider,
                //                       appProvider, context);
                //                   surveyProvider
                //                       .setLoadCreateOrEditSurvey(false);
                //                   Navigator.pushNamedAndRemoveUntil(
                //                       context, '/base', (_) => false);
                //                 } else {
                //                   String url = await _uploadFilesToFirebase
                //                       .uploadSurveyPhoto(
                //                           surveyProvider.selectedPhoto,
                //                           'SURVEY_PHOTO_${Uuid().v4()}');
                //                   surveyProvider.setPhoto(url);
                //                   createSurvey(surveyProvider, storeProvider,
                //                       appProvider, context);
                //                   surveyProvider
                //                       .setLoadCreateOrEditSurvey(false);
                //                   Navigator.pushNamed(context, '/base');
                //                 }
                //               } else {
                //                 if (surveyProvider
                //                     .selectedPhoto.path.isNotEmpty) {
                //                   surveyProvider
                //                       .setLoadCreateOrEditSurvey(true);
                //                   String url = await _uploadFilesToFirebase
                //                       .uploadSurveyPhoto(
                //                           surveyProvider.selectedPhoto,
                //                           'SURVEY_PHOTO_${surveyProvider.survey.id}');
                //                   surveyProvider.setPhoto(url);
                //                   await surveyService.editSurvey(
                //                       surveyProvider.survey, storeProvider);
                //                   surveyProvider.reset();
                //                   storeProvider.reset();
                //                   surveyProvider
                //                       .setLoadCreateOrEditSurvey(false);
                //                   Navigator.pushNamedAndRemoveUntil(
                //                       context, '/base', (_) => false);
                //                 } else {
                //                   await surveyService.editSurvey(
                //                       surveyProvider.survey, storeProvider);
                //                   surveyProvider.reset();
                //                   storeProvider.reset();
                //                   Navigator.pushNamedAndRemoveUntil(
                //                       context, '/base', (_) => false);
                //                 }
                //               }
                //             })
                //       ],
                //     ),
                //   ),
                // );
              }, // Cantidad de elementos en la lista
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.10,
                child: QuickyButton(
                    disabled: surveyProvider.survey.questions!.isEmpty ||
                        surveyProvider.isLoadingCreateOrEditSurvey,
                    type: QuickyButtonTypes.primary,
                    child: const Text(
                      'Finalizar',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    onTap: () async {
                      surveyProvider.setLoadCreateOrEditSurvey(true);

                      if (surveyProvider.surveyAction == SurveyAction.create) {
                        if (surveyProvider.selectedPhoto.path.isEmpty) {
                          createSurvey(surveyProvider, storeProvider,
                              appProvider, couponProvider, context);
                          surveyProvider.setLoadCreateOrEditSurvey(false);
                          surveyProvider.resetCurrentPage();
                          couponProvider.resetCreatedCoupon();
                          couponProvider.resetSelectedCoupon();
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/base', (_) => false);
                        } else {
                          String url =
                              await _uploadFilesToFirebase.uploadSurveyPhoto(
                                  surveyProvider.selectedPhoto,
                                  'SURVEY_PHOTO_${Uuid().v4()}');
                          surveyProvider.setPhoto(url);
                          createSurvey(surveyProvider, storeProvider,
                              appProvider, couponProvider, context);
                          couponProvider.resetCreatedCoupon();
                          couponProvider.resetSelectedCoupon();
                          surveyProvider.setLoadCreateOrEditSurvey(false);
                          surveyProvider.resetCurrentPage();
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/base', (_) => false);
                        }
                      } else {
                        surveyProvider.setLoadCreateOrEditSurvey(true);

                        if (surveyProvider.selectedPhoto.path.isNotEmpty) {
                          String url =
                              await _uploadFilesToFirebase.uploadSurveyPhoto(
                                  surveyProvider.selectedPhoto,
                                  'SURVEY_PHOTO_${surveyProvider.survey.id}');
                          surveyProvider.setPhoto(url);
                          await surveyService.editSurvey(
                              surveyProvider.survey, storeProvider);
                          surveyProvider.reset();
                          storeProvider.reset();
                          couponProvider.resetCreatedCoupon();
                          couponProvider.resetSelectedCoupon();
                          surveyProvider.setLoadCreateOrEditSurvey(false);
                          surveyProvider.resetCurrentPage();
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/base', (_) => false);
                        } else {
                          await surveyService.editSurvey(
                              surveyProvider.survey, storeProvider);
                          surveyProvider.reset();
                          storeProvider.reset();
                          couponProvider.resetCreatedCoupon();
                          couponProvider.resetSelectedCoupon();
                          surveyProvider.resetCurrentPage();
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/base', (_) => false);
                        }
                      }
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void createSurvey(
      SurveyProvider surveyProvider,
      StoreProvider storeProvider,
      AppProvider appProvider,
      CouponProvider couponProvider,
      BuildContext context) async {
    await surveyService.createSurvey(
        surveyProvider.survey,
        storeProvider.selectedStores,
        appProvider.brandDefault.id,
        surveyProvider.couponSelected);
    surveyProvider.reset();
    storeProvider.reset();
  }

  Widget containterContent() {
    return Container(
      height: 50.0,
      color: Colors.cyanAccent,
      margin: const EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width - 100,
      child: const Center(
          child: Text(
        'Item 1',
        style: TextStyle(
          fontSize: 14.0,
        ),
      )),
    );
  }
}
