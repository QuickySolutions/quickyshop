import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/providers/app/appProvider.dart';
import 'package:quickyshop/providers/statistics/statisticsProvider.dart';
import 'package:quickyshop/utils/Colors.dart';
import 'package:quickyshop/widgets/medals/quickyMedal.dart';

class BoxStadistic extends StatelessWidget {
  const BoxStadistic({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final statisticProvider = Provider.of<StatisticProvider>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: QuickyColors.greyColor,
      ),
      padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
      width: MediaQuery.of(context).size.width * 0.90,
      child: Column(
        children: [
          Container(
              height: 30,
              width: 60,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ))),
          SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      Text(
                        '4',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w700),
                      ),
                      Container(
                        width: 80,
                        child: Text(
                          'Encuestas realizadas:',
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                  width: 140,
                  decoration: BoxDecoration(
                      border: Border(
                    right: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    left: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  )),
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        Text(
                          '21',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700),
                        ),
                        Container(
                          width: 80,
                          child: Text(
                            'Cupones canjeados',
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  )),
              Container(
                  decoration: BoxDecoration(border: Border()),
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        Text(
                          '5',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700),
                        ),
                        Container(
                          width: 80,
                          child: Text(
                            'Comercios favoritos',
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Insignias: 8',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 30),
              Image(
                height: 20,
                image: AssetImage('assets/icons/usability/helpButton.png'),
              )
            ],
          ),
          SizedBox(height: 15),
          Container(
            height: 100,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemCount: 3,
                itemBuilder: ((context, index) {
                  return SizedBox(
                    width: 120,
                    child: QuickyMedal(
                      medalName: 'Ejemplo',
                      isUnlocked: false,
                    ),
                  );
                })),
          ),
          SizedBox(height: 20),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.70,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: QuickyColors.secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: () {
                  if (appProvider.hasSelectedBrand) {
                    statisticProvider.setBrandId(appProvider.brandDefault.id);
                    Navigator.pushNamed(context, '/profile/statistics');
                  }
                },
                child: Text(
                  'Ver actividad',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                )),
          ),
        ],
      ),
    );
  }
}
