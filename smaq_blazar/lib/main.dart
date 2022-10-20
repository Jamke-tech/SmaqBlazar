
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:smaq_blazar/screens/home.dart';
import 'package:smaq_blazar/screens/detail_station.dart';

void main() {

  duringSplashFunction() async {

  }


  runApp(MaterialApp(
    title: 'SMAQAPP',
    theme: ThemeData(
      // Here you have to declare the general Thema Data for all the APP
      primarySwatch: Colors.grey,
      fontFamily: "Wallbox",



    ),
    initialRoute: '/home',
    routes: {
      //Here we have to put all the routes to diferent pages
      '/home': (context) => Home(),
      //'/detail_station': (context)=> DetailStation(),
    },
    home: AnimatedSplashScreen(
      splash: 'assets/pictures/SplashLogo.png' ,
      nextScreen: Home(),
      function: duringSplashFunction,
      duration: 4500,
        splashTransition: SplashTransition.fadeTransition,
        //pageTransitionType: PageTransitionType.scale,
        backgroundColor: Colors.black,

      //outputAndHome: 1,

    ),
  ));
}




