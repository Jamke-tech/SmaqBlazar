import 'package:flutter/material.dart';

import 'package:smaq_blazar/screens/home.dart';
import 'package:smaq_blazar/screens/detail_station.dart';

void main() =>  runApp(const SMAQApp());


class SMAQApp extends StatelessWidget {
  const SMAQApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SMAQAPP',
      theme: ThemeData(
        // Here you have to declare the general Thema Data for all the APP
        primarySwatch: Colors.teal,
        fontFamily: "Organo",



      ),
      initialRoute: '/home',
      routes: {
        //Here we have to put all the routes to diferent pages
        '/home': (context) => Home(),
        //'/detail_station': (context)=> DetailStation(),
      },
    );
  }
}


