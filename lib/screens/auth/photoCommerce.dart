import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/firebase/uploadFilesToFirebase.dart';
import 'package:quickyshop/preferences/appPreferences.dart';
import 'package:quickyshop/services/pictureSelectionService.dart';
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
  PictureSelectionService _pictureSelectionService = PictureSelectionService();

  bool isLoadingSaveData = false;

  UploadFilesToFirebase _filesToFirebase = UploadFilesToFirebase();

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
            SizedBox(height: 30),
            ProfileUser(
              height: 200,
              width: 200,
              onTap: () async {
                final image = await _pictureSelectionService.pickImage();
                final imageTemp = File(image.path);
                signUpProvider.setPhisicalPhoto(imageTemp);
                signUpProvider.setPhotoProfile(imageTemp.path);
              },
            ),
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
                  onPressed: () async {
                    await _filesToFirebase.uploadFile(
                        signUpProvider.physicalPhoto,
                        signUpProvider.storeName,
                        signUpProvider);

                    Map<String, dynamic> storeData = {
                      'name': signUpProvider.storeName,
                      'email': signUpProvider.emailStore,
                      'password': signUpProvider.passwordStore,
                      'cellphone': signUpProvider.cellPhoneStore,
                      'principal_category':
                          signUpProvider.principalCategorySelected,
                      'category': signUpProvider.subLevelSelected,
                      'subcategory': signUpProvider.subSubLevelSelected,
                      'photo': signUpProvider.photoProfile
                    };

                    signUpProvider.setPhisicalPhoto(File(''));

                    final response =
                        await _storeService.registerStore(storeData);

                    AppPreferences.setIsLogin('isLogged', true);
                    AppPreferences.setIdBrand(
                        'idBrand', response['data']['_id']);
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
