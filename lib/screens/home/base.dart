import 'package:flutter/material.dart';
import 'package:quickyshop/screens/QR/QR_view.dart';
import 'package:quickyshop/screens/home/home.dart';
import 'package:quickyshop/utils/Colors.dart';

class BaseHomePage extends StatefulWidget {
  const BaseHomePage({super.key});

  @override
  State<BaseHomePage> createState() => _BaseHomePageState();
}

class _BaseHomePageState extends State<BaseHomePage> {
  List<Widget> screens = [HomePage(), QRViewScreen()];
  PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
          height: 130,
          decoration: BoxDecoration(
            color: Colors.transparent,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 6)),
            ],
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: Container(
              child: BottomNavigationBar(
                selectedItemColor: QuickyColors.primaryColor,
                unselectedItemColor: Colors.grey,
                currentIndex: 0,
                onTap: (index) {
                  _pageController.jumpToPage(index);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Container(
                        padding: EdgeInsets.only(top: 30),
                        child: Icon(Icons.home, size: 35),
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: Container(
                        padding: EdgeInsets.only(top: 30),
                        child: Icon(Icons.qr_code, size: 35),
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: Container(
                        padding: EdgeInsets.only(top: 30),
                        child: Icon(Icons.notifications, size: 35),
                      ),
                      label: ''),
                ],
              ),
            ),
          )),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {});
        },
        itemBuilder: (BuildContext context, int index) {
          return screens[index];
        },
      ),
    );
  }
}