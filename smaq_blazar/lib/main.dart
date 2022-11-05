
import 'package:SMAQ/screens/AQI_evolution.dart';
import 'package:SMAQ/screens/detail_station.dart';
import 'package:SMAQ/screens/graphs.dart';
import 'package:SMAQ/screens/home.dart';
import 'package:SMAQ/services/Data_service.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
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
    print("Stations Saved");

    await stationsManager.SaveStations(listStations);





    return Home();
  }

  runApp(MaterialApp(
    title: 'SMAQ',
    theme: ThemeData(
      // Here you have to declare the general Thema Data for all the APP
      primarySwatch: Colors.blueGrey,
      fontFamily: "Wallbox",
    ),
    //initialRoute: '/home',
    routes: {
      //Here we have to put all the routes to diferent pages
      '/home': (context) => Home(),
      '/detail_station': (context)=> const DetailStation(),
      '/graphs_station':(context)=> const GraphsStation(),
      '/evolution_station':(context)=> const EvolutionStation(),
    },
    home: AnimatedSplashScreen.withScreenFunction(
      splash: getSplash(),
      screenFunction: duringSplashFunction,
      duration: 2000,
      splashTransition: SplashTransition.fadeTransition,
      //pageTransitionType: PageTransitionType.scale,
      backgroundColor: const Color(0xFFc8c8c7),
      splashIconSize: 300,

      //outputAndHome: 1,
    ),
  ));
}
Widget getSplash(){

  return Container(

    child: Column(
      children: [
        Container(
          width: 250,
            height: 250,
            child: Image.asset("assets/pictures/SMAQ.png")),
        AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText("Buscant informació dels SMAQ's ...",
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,)),
            TyperAnimatedText('Extraïent dades de contaminació...',
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,)),
            TyperAnimatedText('Ja casi hem acabat...',
                textStyle: const TextStyle(
                  color: Colors.black,
                    fontSize: 15, fontWeight: FontWeight.bold)),
          ],
          onTap: () {
            print("I am executing");
          },
        ),

      ],
    ),
  );




}
