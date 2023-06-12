import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/signup/signup_provider.dart';
import '../../services/storeService.dart';
import '../../utils/Colors.dart';
import '../../widgets/app/ProfileUser.dart';
import '../../widgets/scaffolds/authScaffold.dart';

class DefinePhotoCommerceScreen extends StatefulWidget {
  const DefinePhotoCommerceScreen({super.key});

  @override
  State<DefinePhotoCommerceScreen> createState() =>
      _DefinePhotoCommerceScreenState();
}

class _DefinePhotoCommerceScreenState extends State<DefinePhotoCommerceScreen> {
  StoreService _storeService = StoreService();
  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);
    return QuickyAuthScaffold(
      currentScreenType: 'register',
      contentScreen: Container(
        margin: EdgeInsets.only(
          top: 40,
        ),
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 80),
              child: Image(
                height: 180,
                width: 180,
                image: AssetImage('assets/icons/brand/quiky.png'),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                'Escoge una imagen para tu comercio',
                textAlign: TextAlign.center,
              ),
            ),
            ProfileUser(),
            SizedBox(height: 30),
            Container(
              height: 65,
              width: MediaQuery.of(context).size.width * 0.75,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: QuickyColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: () {
                    Map<String, dynamic> storeData = {
                      'name': signUpProvider.storeName,
                      'email': signUpProvider.emailStore,
                      'password': signUpProvider.passwordStore,
                      'cellphone': signUpProvider.cellPhoneStore,
                      'principal_category':
                          signUpProvider.principalCategorySelected,
                      'category': signUpProvider.subLevelSelected,
                      'subcategory': signUpProvider.subSubLevelSelected
                    };

                    _storeService.registerStore(storeData);

                    Navigator.pushNamed(context, '/home');
                  },
                  child: Text(
                    'Guardar',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
