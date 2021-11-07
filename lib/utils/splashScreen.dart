import 'package:flutter/material.dart';
import 'package:qasimati/utils/ChosseCountry.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new ChoseCountry(),
        image: new Image.asset(
          'assets/images/Logo.png',
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.white);
  }
}
