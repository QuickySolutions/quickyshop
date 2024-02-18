import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/firebase/uploadFilesToFirebase.dart';
import 'package:quickyshop/preferences/appPreferences.dart';
import 'package:quickyshop/providers/app/appProvider.dart';
import 'package:quickyshop/providers/photo/photo_provider.dart';
import 'package:quickyshop/services/brandService.dart';
import '../../providers/signup/signup_provider.dart';
import '../../services/storeService.dart';
import '../../utils/Colors.dart';
import '../../widgets/scaffolds/authScaffold.dart';

class DefinePhotoCommerceScreen extends StatefulWidget {
  const DefinePhotoCommerceScreen({super.key});

  @override
  State<DefinePhotoCommerceScreen> createState() =>
      _DefinePhotoCommerceScreenState();
}

class _DefinePhotoCommerceScreenState extends State<DefinePhotoCommerceScreen> {
  final StoreService _storeService = StoreService();
  final BrandService _brandService = BrandService();
  bool isLoadingSaveData = false;

  UploadFilesToFirebase _filesToFirebase = UploadFilesToFirebase();

  late File imageFile = File("");
  bool pickedImage = false;

  // Get from gallery
  _getFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFile = File(image.path);
      pickedImage = true;
      setState(() {});
    }
  }

  Future<void> createBranchOrBranchOffice(SignUpProvider signUpProvider,
      AppProvider appProvider, String photo) async {
    Map<String, dynamic> storeData = {
      'name': signUpProvider.storeName,
      'email': signUpProvider.emailStore,
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
      'photo': photo,
      'brandId':
          appProvider.wantToAddNewStore ? appProvider.brandDefault.id : null
    };

    if (!appProvider.wantToAddNewStore) {
      final response = await _storeService.createBranch(storeData);
      signUpProvider.clearAll();
      AppPreferences().setIdBrand(response['data']['_id']);
      appProvider.setDefaultBrand(response['data']);
    } else {
      signUpProvider.clearAll();
      await _brandService.createBranchOffice(
          appProvider.brandDefault.id, storeData);
      appProvider.setWantToAddNewStore(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);
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
            const Padding(
              padding: EdgeInsets.only(top: 80),
              child: Image(
                height: 180,
                width: 180,
                image: AssetImage('assets/icons/brand/quiky.png'),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                'Escoge una imagen para tu comercio',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 280,
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: (200 + 10),
                    width: (200 + 10),
                    child: CircularProgressIndicator(
                      backgroundColor: QuickyColors.greyColor,
                      strokeWidth: 3,
                      color: QuickyColors.primaryColor,
                      value: .0,
                    ),
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      child: showPhoto(signUpProvider)),
                  Positioned(
                      bottom: 0,
                      right: 70,
                      child: GestureDetector(
                        onTap: () {
                          _getFromGallery();
                        },
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: QuickyColors.primaryColor,
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ))
                ],
              ),
            ),
            const SizedBox(height: 30),
            signUpProvider.photoProfile.isNotEmpty && pickedImage
                ? Column(children: [
                    restorePhotoFromGoogle(),
                    const SizedBox(height: 30),
                  ])
                : Container(),
            SizedBox(
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
                  onPressed: signUpProvider.isLoading
                      ? null
                      : () async {
                          if (pickedImage) {
                            late String url = "";
                            signUpProvider.setIsLoading(true);
                            url = await uploadPhotoToFirebase(
                                signUpProvider, appProvider);
                            await createBranchOrBranchOffice(
                                signUpProvider, appProvider, url);

                            signUpProvider.setPhotoProfile(url);
                            signUpProvider.setIsLoading(false);
                          } else if (signUpProvider.photoProfile.isNotEmpty) {
                            await createBranchOrBranchOffice(signUpProvider,
                                appProvider, signUpProvider.photoProfile);
                            signUpProvider
                                .setPhotoProfile(signUpProvider.photoProfile);
                            signUpProvider.setIsLoading(false);
                          } else {
                            await createBranchOrBranchOffice(
                                signUpProvider, appProvider, "");
                            signUpProvider.setPhotoProfile("");
                            signUpProvider.setIsLoading(false);
                          }

                          Navigator.pushNamedAndRemoveUntil(
                              context, "/base", (r) => false);
                        },
                  child: Text(
                    signUpProvider.isLoading ? 'Cargando...' : 'Guardar',
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

  Widget showPhoto(SignUpProvider signUpProvider) {
    if (signUpProvider.photoProfile.isNotEmpty && !pickedImage) {
      return FadeInImage(
        height: double.infinity,
        fit: BoxFit.cover,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image(image: AssetImage('assets/images/not-available.png'));
        },
        placeholder: const AssetImage('assets/utils/loading.gif'),
        image: NetworkImage(signUpProvider.photoProfile),
      );
    } else if (!pickedImage) {
      return const FadeInImage(
        height: double.infinity,
        fit: BoxFit.cover,
        placeholder: AssetImage('assets/utils/loading.gif'),
        image: AssetImage("assets/images/not-available.png"),
      );
    } else {
      return Image.file(
        imageFile,
        height: double.infinity,
        width: 200,
        fit: BoxFit.cover,
      );
    }
  }

  Widget restorePhotoFromGoogle() {
    return GestureDetector(
      onTap: () {
        setState(() {
          pickedImage = !pickedImage;
          imageFile = File("");
        });
      },
      child: const Text('Restablecer foto',
          style: TextStyle(decoration: TextDecoration.underline)),
    );
  }

  Future<String> uploadPhotoToFirebase(
      SignUpProvider signUpProvider, AppProvider appProvider) async {
    late String url;
    url = await _filesToFirebase.uploadPhoto(
        imageFile, imageFile.hashCode.toString(), true);
    return url;
  }
}
