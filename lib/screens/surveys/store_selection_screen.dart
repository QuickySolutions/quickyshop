import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/providers/store/store_provider.dart';
import 'package:quickyshop/providers/survey/survey_provider.dart';
import 'package:quickyshop/utils/Colors.dart';
import 'package:quickyshop/widgets/app/goBackButton.dart';
import 'package:quickyshop/widgets/buttons/quickyButton.dart';
import 'package:quickyshop/widgets/dialogs/stores/store_list.dart';

class StoreSelectionScreen extends StatefulWidget {
  const StoreSelectionScreen({super.key});

  @override
  State<StoreSelectionScreen> createState() => _StoreSelectionScreenState();
}

class _StoreSelectionScreenState extends State<StoreSelectionScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<StoreProvider>(context);
    final surveyProvider = Provider.of<SurveyProvider>(context);
    return Container(
        child: Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 20, left: 15, right: 15),
          child: Row(
            children: [
              Flexible(
                child: Text(
                    'Selecciona una tienda o varias tiendas para almacenar la encuesta'),
              ),
              GoBackButton(
                onTap: () {
                  surveyProvider.goBackPage();
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          child: Row(
            children: [
              Transform.scale(
                scale: 1.2,
                child: Checkbox(
                    checkColor: Colors.white,
                    activeColor: QuickyColors.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    value: storeProvider.wantToSaveInAllStores,
                    onChanged: (value) {
                      storeProvider.onSaveInAllStores(value!);
                    }),
              ),
              Text('Enviar esta encuesta a todas las tiendas')
            ],
          ),
        ),
        Expanded(child: StoreList()),
        QuickyButton(
            disabled: storeProvider.selectedStores.isEmpty,
            type: QuickyButtonTypes.primary,
            child: Text(
              'Continuar',
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {
              surveyProvider.changePage();
            })
      ],
    ));
  }
}
