import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/preferences/appPreferences.dart';
import 'package:quickyshop/providers/app/appProvider.dart';
import 'package:quickyshop/providers/auth/profileProvider.dart';
import 'package:quickyshop/services/brandService.dart';
import 'package:quickyshop/widgets/app/goBackButton.dart';
import 'package:quickyshop/services/storeService.dart';
import 'package:quickyshop/widgets/app/ProfileUser.dart';
import 'package:quickyshop/widgets/profile/editFormProfile.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  BrandService _brandService = BrandService();
  StoreService _storeService = StoreService();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      final appProvider = Provider.of<AppProvider>(context, listen: false);

      if (appProvider.hasSelectedBrand) {
        profileProvider.onChangeName(appProvider.brandDefault.name);
        profileProvider.onChangeEmail(appProvider.brandDefault.email);
        profileProvider.onChangeCellPhone(appProvider.brandDefault.cellphone);
        profileProvider.onChangePhoto(appProvider.brandDefault.photo);
      } else {
        profileProvider.onChangeName(appProvider.storeSelected.name);
        profileProvider.onChangeEmail(appProvider.storeSelected.email);
        profileProvider.onChangePhoto(appProvider.storeSelected.photo);
        profileProvider.onChangeLocation(appProvider.storeSelected.photo);
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 60),
                        alignment: Alignment.center,
                        child: ProfileUser(
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                    GoBackButton(
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              profileProvider.showForm ? EditProfileForm() : Container(),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: FilledButton.tonal(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 192, 226, 255)),
                      ),
                      onPressed: () async {
                        if (profileProvider.showForm) {
                          if (appProvider.hasSelectedBrand) {
                            profileProvider.setIsLoading(true);
                            final data = await _brandService.updateBrand(
                                appProvider.brandDefault.id,
                                profileProvider.toBrand());

                            appProvider.setDefaultBrand(data['data']['value']);

                            profileProvider.setIsLoading(false);
                            profileProvider.showFormProfile(false);
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/base", (r) => false);
                          } else {
                            //profileProvider.setIsLoading(true);
                            final data = await _storeService.updateStore(
                                appProvider.storeSelected.id!,
                                profileProvider.toStore());
                            appProvider.setDefaultStore(data['data']['value']);

                            profileProvider.setIsLoading(false);
                            profileProvider.showFormProfile(false);
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/base", (r) => false);
                          }
                        } else {
                          profileProvider.showFormProfile(true);
                        }
                      },
                      child: Text(
                        profileProvider.isLoading
                            ? 'Cargando...'
                            : appProvider.hasSelectedBrand
                                ? 'Editar perfil comercial'
                                : 'Editar subtienda',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: FilledButton.tonal(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 255, 192, 192)),
                      ),
                      onPressed: () {
                        appProvider.reset();
                        AppPreferences().setIdBrand("");
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/", (r) => false);
                      },
                      child: Text(
                        'Cerrar sesión',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w700),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
