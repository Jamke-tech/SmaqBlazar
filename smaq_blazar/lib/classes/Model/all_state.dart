
import 'package:flutter/material.dart';
import 'package:rainbow_color/rainbow_color.dart';

class AllState {
  //Model to get the info from OpenSky api
  //Info from : https://openskynetwork.github.io/opensky-api/rest.html
  final String icao24;
  final String callSign;
  final int timePosition;
  final double verticalVel;
  final double horizontalVel;
  final String origin;
  final double long;
  final double lat;
  final double baroAltitude;
  final double trueTrack;
  final bool onGround;
  final double geoAltitude;



  AllState({required this.icao24,
      required this.callSign,
      required this.timePosition,
      required this.long,
      required this.lat,
    required this.origin,
      required this.baroAltitude,
    required this.trueTrack,
      required this.onGround,
      required this.geoAltitude,
    required this.horizontalVel,
    required this.verticalVel
  });

  factory AllState.fromJson(dynamic json){
    if (json == null) {
      return AllState(
          icao24:"000",
          callSign:"NONE",
          origin:"CATALONIA",
          timePosition:0,
          long:0,
          lat:0,
          baroAltitude:-1,
          trueTrack: 0,
          onGround:true,
          geoAltitude:-1,
        verticalVel: 0,
        horizontalVel: 0,
          );

    }
    return AllState(
      icao24: json[0] ,
      callSign: (null!=json[1])?json[1]:"No CallSign",
      origin: (null!=json[2])?json[2]:"No Origin",
      timePosition:(null!=json[3])?json[3]:0,
      verticalVel:(null!=json[11])? double.parse(json[11].toString()):0,
      horizontalVel: (null!=json[9])? double.parse(json[9].toString()):0,
      long:(null!=json[5])? double.parse(json[5].toString()):0,
      lat:(null!=json[6])?double.parse(json[6].toString()):0,
      baroAltitude:(null!=json[7])?double.parse(json[7].toString()):0,
      trueTrack:(null!=json[10])?double.parse(json[10].toString()):0,
      onGround:(null!=json[8])?json[8]:true,
      geoAltitude:(null!=json[13])?double.parse(json[13].toString()):0,
      //category: json[17],
    );
  }
  dynamic getFlightColor(){

    if(onGround){
      return Colors.blueGrey.shade400;
      //color:flight.icao24==flightShown.icao24 ? const Color(0xff00877F) : ( flight.onGround ? Colors.blueGrey.shade400  : Colors.black ) ,
    }else{
      if(baroAltitude<100){
        return Color(0xff8CE0B0);
      }else if(baroAltitude>=100 && baroAltitude<300){
        return Color(0xff69debf);
      }else if(baroAltitude>=300 && baroAltitude<600){
        return  Color(0xff43c7da);
      }else if(baroAltitude>=600 && baroAltitude<1000){
        return Color(0xff2b8dd7);
      }else if(baroAltitude>=1000 && baroAltitude<1500){
        return Color(0xff0d4694);
      }else{
        return Color(0xff0b1e5e);
      }



    }
  }


}