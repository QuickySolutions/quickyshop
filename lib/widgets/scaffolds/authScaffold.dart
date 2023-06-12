import 'package:flutter/material.dart';

class QuickyAuthScaffold extends StatefulWidget {
  final String currentScreenType;
  final Widget contentScreen;
  const QuickyAuthScaffold(
      {super.key,
      required this.currentScreenType,
      required this.contentScreen});

  @override
  State<QuickyAuthScaffold> createState() => _QuickyAuthScaffoldState();
}

class _QuickyAuthScaffoldState extends State<QuickyAuthScaffold> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                  getBackgroundByAuthScreen(widget.currentScreenType)))),
      child: Scaffold(
          backgroundColor: Colors.transparent, body: widget.contentScreen),
    );
  }

  String getBackgroundByAuthScreen(String screenName) {
    String routeBackgroundAsset = "";
    switch (screenName) {
      case 'principal':
        routeBackgroundAsset = 'assets/backgrounds/border-principal.png';
        break;
      case 'send-code':
        routeBackgroundAsset = 'assets/backgrounds/border-register.png';
        break;
      case 'verify-code':
        routeBackgroundAsset = 'assets/backgrounds/login-borders.png';
        break;
      case 'register':
        routeBackgroundAsset = 'assets/backgrounds/border-register.png';
        break;
      case 'define-category':
        routeBackgroundAsset = 'assets/backgrounds/border-top.png';
        break;
      case 'photo-commerce':
        routeBackgroundAsset = 'assets/backgrounds/border-register.png';
        break;
      default:
    }
    return routeBackgroundAsset;
  }
}
