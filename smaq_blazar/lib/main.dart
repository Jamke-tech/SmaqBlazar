
import 'package:SMAQ/screens/detail_station.dart';
import 'package:SMAQ/screens/home.dart';
import 'package:SMAQ/services/Data_service.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';


import 'classes/station_model.dart';
import 'services/Station_service.dart';

void main() {
  Future<Widget> duringSplashFunction() async {

    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    late LocationData locationData;
    Location userLocation = Location();

    //We have to refresh the information from the BBDD that we have
    StationsManager stationsManager = StationsManager();
    DataManager dataManager = DataManager();

    List<StationModel> listStations =
        await stationsManager.getAllStationsWithLastData();

    await stationsManager.SaveStations(listStations);


    /*serviceEnabled = await userLocation.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await userLocation.requestService();
      if (!serviceEnabled) {

      }
    }
    permissionGranted = await userLocation.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await userLocation.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {

      }
    }
    locationData = await userLocation.getLocation();

    await stationsManager.saveLocation(locationData);*/


    return Home();
  }

  runApp(MaterialApp(
    title: 'SMAQAPP',
    theme: ThemeData(
      // Here you have to declare the general Thema Data for all the APP
      primarySwatch: Colors.blueGrey,
      fontFamily: "Wallbox",
    ),
    //initialRoute: '/home',
    routes: {
      //Here we have to put all the routes to diferent pages
      '/home': (context) => Home(),
      '/detail_station': (context)=> DetailStation(),
    },
    home: AnimatedSplashScreen.withScreenFunction(
      splash: "assets/pictures/SMAQ.png",
      screenFunction: duringSplashFunction,
      duration: 2500,
      splashTransition: SplashTransition.fadeTransition,
      //pageTransitionType: PageTransitionType.scale,
      backgroundColor: Color(0xFFc8c8c7),

      //outputAndHome: 1,
    ),
  ));
}
