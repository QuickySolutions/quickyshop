import 'package:flutter/material.dart';
import 'package:quickyshop/screens/app/goBackButton.dart';
import 'package:quickyshop/utils/Colors.dart';
import 'package:quickyshop/widgets/buttons/quickyButton.dart';
import 'package:quickyshop/widgets/inputs/quicky_textfield.dart';

class CreateSurveyScreen extends StatelessWidget {
  const CreateSurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                backgroundSurvey(),
                principalFormSurvey(context),
                SizedBox(height: 20),
                buttonsSurveys(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget backgroundSurvey() {
  return Container(
    color: Color(0xff9C9FA0),
    width: double.infinity,
    height: 150,
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
                      image:
                          AssetImage('assets/icons/usability/edit_white.png')),
                ),
                SizedBox(
                  width: 15,
                ),
                Text('Añadir foto')
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget principalFormSurvey(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(top: 30, bottom: 10, left: 30, right: 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nombre de la encuesta:'),
        SizedBox(height: 15),
        QuickyTextField(),
        SizedBox(height: 15),
        Text('Descripción (opcional)'),
        SizedBox(height: 15),
        QuickyTextArea(maxLines: 5),
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
                      onTap: () async {},
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
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100));
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

Widget buttonsSurveys(BuildContext context) {
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
