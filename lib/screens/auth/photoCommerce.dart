import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/firebase/uploadFilesToFirebase.dart';
import 'package:quickyshop/preferences/appPreferences.dart';
import 'package:quickyshop/providers/app/appProvider.dart';
import 'package:quickyshop/providers/photo/photo_provider.dart';
import 'package:quickyshop/services/brandService.dart';
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
  BrandService _brandService = BrandService();
  bool isLoadingSaveData = false;

  UploadFilesToFirebase _filesToFirebase = UploadFilesToFirebase();

  void createBranchOrBranchOffice(SignUpProvider signUpProvider,
      AppProvider appProvider, String photoUrl) async {
    Map<String, dynamic> storeData = {
      'name': signUpProvider.storeName,
      'email': appProvider.wantToAddNewStore
          ? appProvider.brandDefault.email
          : signUpProvider.emailStore,
      'password': signUpProvider.passwordStore,
      'location': signUpProvider.storeLocation,
      'cellphone': signUpProvider.cellPhoneStore,
      'principal_category': appProvider.wantToAddNewStore
          ? appProvider.brandDefault.principalCategory
          : signUpProvider.principalCategorySelected,
      'category': appProvider.wantToAddNewStore
          ? appProvider.brandDefault.category
          : signUpProvider.subLevelSelected,
      'subcategory': appProvider.wantToAddNewStore
          ? appProvider.brandDefault.subCategory
          : signUpProvider.subSubLevelSelected,
      'photo': photoUrl,
      'brandId':
          appProvider.wantToAddNewStore ? appProvider.brandDefault.id : null
    };

    if (!appProvider.wantToAddNewStore) {
      final response = await _storeService.createBranch(storeData);

      AppPreferences().setIdBrand(response['data']['_id']);
    } else {
      await _brandService.createBranchOffice(
          appProvider.brandDefault.id, storeData);
      appProvider.setWantToAddNewStore(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);
    final photoProvider = Provider.of<PhotoProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
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
            Container(
              width: 280,
              child: ProfileUser(
                height: 200,
                width: 200,
                editPicture: true,
              ),
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
                    String url = await _filesToFirebase.uploadFile(
                        photoProvider.photo!,
                        signUpProvider.storeName,
                        signUpProvider,
                        photoProvider,
                        appProvider.wantToAddNewStore);
                    createBranchOrBranchOffice(
                        signUpProvider, appProvider, url);
                    signUpProvider.setPhotoProfile(url);
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/base", (r) => false);
                    photoProvider.uploadPicToFirebase(false);
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
