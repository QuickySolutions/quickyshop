import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/models/Store.dart';
import 'package:quickyshop/preferences/appPreferences.dart';
import 'package:quickyshop/providers/app/appProvider.dart';
import 'package:quickyshop/providers/statistics/statisticsProvider.dart';
import 'package:quickyshop/providers/survey/survey_provider.dart';
import 'package:quickyshop/services/brandService.dart';
import 'package:quickyshop/services/storeService.dart';
import 'package:quickyshop/widgets/brand/brand-mini-card.dart';

import '../../utils/Colors.dart';
import '../../widgets/app/ProfileUser.dart';
import '../../widgets/buttons/buttonLeadButton.dart';
import '../../widgets/store/store-mini-card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoadingBrandInformation = true;
  final BrandService _brandService = BrandService();
  final StoreService _storeService = StoreService();
  int selectedStore = -1;

  Future<void> getBrandInformation() async {
    //final signupProvider = Provider.of<SignUpProvider>(context, listen: false);
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    final Map<String, dynamic> brand =
        await _brandService.getBrandInformation(appProvider.brandDefault.id);
    appProvider.setDefaultBrand(brand['data']);
    setState(() {
      isLoadingBrandInformation = false;
    });
  }

  Future<void> getStoreInformation() async {
    //final signupProvider = Provider.of<SignUpProvider>(context, listen: false);
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    final StoreResponse store =
        await _storeService.getStoreInformation(appProvider.storeSelected.id!);
    appProvider.setDefaultStore(store.data);
    setState(() {
      isLoadingBrandInformation = false;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appProvider = Provider.of<AppProvider>(context, listen: false);

      if (appProvider.hasSelectedStore) {
        getStoreInformation();
      } else {
        getBrandInformation();
      }
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final surveyProvider = Provider.of<SurveyProvider>(context);
    final statisticProvider = Provider.of<StatisticProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoadingBrandInformation
          ? RefreshIndicator(
              onRefresh: appProvider.hasSelectedBrand
                  ? getBrandInformation
                  : getStoreInformation,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Text('Cargando información'),
                  ),
                ),
              ),
            )
          : RefreshIndicator(
              onRefresh: appProvider.hasSelectedBrand
                  ? getBrandInformation
                  : getStoreInformation,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.only(top: 50, bottom: 20),
                  child: Column(
                    children: [
                      appProvider.hasSelectedBrand
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Tienda',
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.grey),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Principal',
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.black),
                                      )
                                    ],
                                  ),
                                  ProfileUser(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/profile');
                                    },
                                  )
                                ],
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      appProvider.storeSelected.name,
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.grey),
                                    ),
                                  ),
                                  ProfileUser(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/profile');
                                    },
                                  )
                                ],
                              ),
                            ),
                      SizedBox(height: 20),
                      appProvider.hasSelectedBrand ||
                              appProvider.brandDefault.id.isNotEmpty
                          ? FutureBuilder(
                              future: _brandService.branchOfficesByBrand(
                                  AppPreferences().brandId),
                              builder: (context,
                                  AsyncSnapshot<List<Store>> snapshot) {
                                if (snapshot.hasData) {
                                  return Container(
                                    height: 120,
                                    child: ListView(
                                      padding: EdgeInsets.only(
                                          top: 5, bottom: 5, left: 20),
                                      scrollDirection: Axis.horizontal,
                                      children: <Widget>[
                                        BrandMiniCard(
                                          brand: appProvider.brandDefault,
                                          isSelected:
                                              appProvider.hasSelectedBrand &&
                                                  !appProvider.hasSelectedStore,
                                        ),
                                        Row(
                                            children: snapshot.data!.map((e) {
                                          return Container(
                                            width: 280,
                                            margin: EdgeInsets.only(right: 20),
                                            child: StoreMiniCard(
                                                showImage: true,
                                                onTap: () {
                                                  appProvider.selectStore(e);
                                                },
                                                store: e,
                                                isSelected:
                                                    appProvider.hasSelectedStore
                                                        ? e.id ==
                                                            appProvider
                                                                .storeSelected
                                                                .id
                                                        : false),
                                          );
                                        }).toList()),
                                      ],
                                    ),
                                  );
                                } else {
                                  return CircularProgressIndicator();
                                }
                              })
                          : Container(),
                      !appProvider.hasSelectedStore
                          ? ButtonLeadButton()
                          : Container(),
                      // SizedBox(height: 10),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 20),
                      //   child: Image(
                      //     image: AssetImage('assets/images/example-graph.png'),
                      //   ),
                      // ),
                      SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Encuesta más popular: ',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Ver todas',
                              style: TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.underline),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 120,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/surveys');
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(height: 10),
                                        Text('Ver encuestas',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                overflow:
                                                    TextOverflow.ellipsis))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: SizedBox(
                                height: 120,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/coupons');
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(height: 10),
                                        Text('Cupones',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                overflow:
                                                    TextOverflow.ellipsis))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: SizedBox(
                                width: 100,
                                height: 120,
                                child: GestureDetector(
                                  onTap: () {
                                    if (appProvider.hasSelectedBrand) {
                                      statisticProvider.setBrandId(
                                          appProvider.brandDefault.id);
                                      Navigator.pushNamed(
                                          context, '/profile/statistics');
                                    } else {
                                      statisticProvider.setStoreId(
                                          appProvider.storeSelected.id!);
                                      Navigator.pushNamed(
                                          context, '/profile/statistics');
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(height: 10),
                                        Text('Estadisticas',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                overflow:
                                                    TextOverflow.ellipsis))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      appProvider.hasSelectedBrand
                          ? Container(
                              height: 65,
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: QuickyColors.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  onPressed: () {
                                    surveyProvider.setPage(0);
                                    Navigator.pushNamed(
                                        context, '/create/survey');
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
                                        'Crear nueva encuesta',
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  )),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
