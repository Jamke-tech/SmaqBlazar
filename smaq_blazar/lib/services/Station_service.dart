import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';


import '../api/endpoints.dart';
import '../classes/station.dart';
import '../classes/station_model.dart';



class StationsManager {
  static final StationsManager _instance = StationsManager._internal();

  factory StationsManager(){
    return _instance;
  }
  StationsManager._internal() {
    // initialization logic
  }

  //Recuperem els endpoints de la clase
  Endpoints endpoints = Endpoints();

  //Function to create a new Station
  Future<bool> insertStation(StationModel station) async {
    try {


      print(station.IDStation);
      var headers = {
        'Content-Type': 'application/json',
        'api-key': 'MZpxcJNBp1UMJ8JGdnbH5lhR7sAt3CEiREyVlyfEjFkZBD6vuhE960x9TmQD5GHs'
      };
      var request = http.Request('POST', Uri.parse('https://data.mongodb-api.com/app/data-ugjsw/endpoint/data/v1/action/insertOne'));
      request.body = json.encode({
        "dataSource": endpoints.MongoDbCluster,
        "database": endpoints.DataBaseName,
        "collection": endpoints.MongoDbCollectionStations,
        "document": {
          "StationID": station.IDStation,
          "name": station.name,
          "description": station.Description,
          "lat": station.lat,
          "long": station.long,
        }
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      print(response.statusCode);
      if(response.statusCode==201 || response.statusCode==200){
        //Station upload correctly
        return false;
      }else{
        return true;
      }

    } catch (error) {
      print(error);
      return true;
    }
  }

  Future<List<StationModel>> getAllStation() async {
    try {


      var headers = {
        'Content-Type': 'application/json',
        'api-key': 'MZpxcJNBp1UMJ8JGdnbH5lhR7sAt3CEiREyVlyfEjFkZBD6vuhE960x9TmQD5GHs'
      };
      var request = http.Request('POST', Uri.parse('https://data.mongodb-api.com/app/data-ugjsw/endpoint/data/v1/action/find'));
      request.body = json.encode({
        "dataSource": endpoints.MongoDbCluster,
        "database": endpoints.DataBaseName,
        "collection": endpoints.MongoDbCollectionStations,
        "sort": {
          "StationID": 1,
        }
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      print(response.statusCode);
      if(response.statusCode==200){
        var realResponse = await http.Response.fromStream(response);
        List<dynamic> StationList= jsonDecode(realResponse.body)["documents"];
        List<StationModel> stationsReturn = [];

        for (var station in StationList) {
          stationsReturn.add(StationModel(name: station["name"], IDStation: station["StationID"], Description: station["description"], lat: station["lat"], long: station["long"]));
        }



        //Station upload correctly
        return stationsReturn;
      }else{
        return [];
      }

    } catch (error) {
      print(error);
      return [];
    }
  }

}
