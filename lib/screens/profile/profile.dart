import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/providers/app/appProvider.dart';
import 'package:quickyshop/screens/app/goBackButton.dart';
import 'package:quickyshop/services/storeService.dart';
import 'package:quickyshop/utils/Colors.dart';
import 'package:quickyshop/widgets/app/ProfileUser.dart';
import 'package:quickyshop/widgets/profile/boxStadistic.dart';
import 'package:quickyshop/widgets/profile/chipRankingItem.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  StoreService _storeService = StoreService();
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
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
                    GoBackButton()
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: Text(
                  appProvider.hasSelectedBrand
                      ? appProvider.brandDefault.name
                      : appProvider.storeSelected.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                child: Text(
                  appProvider.hasSelectedStore
                      ? appProvider.storeSelected.location
                      : '',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 15, color: QuickyColors.disableColor),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChipRankingItem(),
                  ChipRankingItem(),
                  ChipRankingItem(),
                ],
              ),
              SizedBox(height: 20),
              Text(
                appProvider.hasSelectedBrand
                    ? appProvider.brandDefault.category
                    : appProvider.storeSelected.category,
                style:
                    TextStyle(color: QuickyColors.disableColor, fontSize: 18),
              ),
              SizedBox(height: 20),
              BoxStadistic(),
              SizedBox(height: 20),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: FilledButton.tonal(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 192, 226, 255)),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Editar subtienda',
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
                        _storeService.changeStatusStore(
                            appProvider.storeSelected.id!, false);
                      },
                      child: Text(
                        'Deshabilitar',
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
