import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import '../api/endpoints.dart';
import '../classes/data_model.dart';
import '../classes/station_model.dart';


class DataManager {
  static final DataManager _instance = DataManager._internal();

  factory DataManager(){
    return _instance;
  }

  DataManager._internal() {
    // initialization logic
  }

  //Recuperem els endpoints de la clase
  Endpoints endpoints = Endpoints();

  //Function to get last Data from station

  Future<List<DataStation>> getDataStation(String IDStation) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'api-key': 'MZpxcJNBp1UMJ8JGdnbH5lhR7sAt3CEiREyVlyfEjFkZBD6vuhE960x9TmQD5GHs'
      };
      var request = http.Request('POST', Uri.parse(
          'https://data.mongodb-api.com/app/data-ugjsw/endpoint/data/v1/action/find'));
      request.body = json.encode({
        "dataSource": endpoints.MongoDbCluster,
        "database": endpoints.DataBaseName,
        "collection": endpoints.MongoDbCollectionDataCollected,
        "filter": {
          "StationID": IDStation
        },
        "sort": {
          "CreationDate": -1, //We want the last data value
        },
        "limit": 288, //Són dades de 24h en teoria com a màxim
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      print(response.statusCode);
      List<DataStation> listData = [];
      if (response.statusCode == 200) {
        var realResponse = await http.Response.fromStream(response);
        List<dynamic> listDocs = jsonDecode(realResponse.body)["documents"];

        //print(listDocs[0].toString());
        //print("DOCS: ${listDocs.length}");
        //print(listDocs[0]);
        if(listDocs.isNotEmpty){


          //print(listDocs[0]["Weather"]["Humidity"]);

          for(int i = 0; i<listDocs.length;i++){
            //We add to the vector the value in decendant order
            listData.add(DataStation(StationID: listDocs[i]["StationID"],
                CreationDate: listDocs[i]["CreationDate"],
                Humidity: listDocs[i]["Weather"]["Humidity"].toDouble(),
                Temperature: listDocs[i]["Weather"]["Temperature"].toDouble(),
                Pressure: listDocs[i]["Weather"]["Pressure"].toDouble(),
                Rain: listDocs[i]["Weather"]["Rain"].toDouble(),
                //As we save the pollutants in ppb we have to divide the ppb by 1000 to get ppm
                CxCO: listDocs[i]["Pollutants"]["CxCO"].toDouble()/1000,
                CxNO2: listDocs[i]["Pollutants"]["CxNO2"].toDouble()/1000,
                CxO3: listDocs[i]["Pollutants"]["CxO3"].toDouble()/1000,
                CxSO2: listDocs[i]["Pollutants"]["CxSO2"].toDouble()/1000,
                PM10: listDocs[i]["Particles"]["PM10"],
                PM25: listDocs[i]["Particles"]["PM25"],
                BlueLux: listDocs[i]["Light"]["BlueLux"].toDouble(),
                GreenLux: listDocs[i]["Light"]["GreenLux"].toDouble(),
                IR: listDocs[i]["Light"]["IR"].toDouble(),
                RedLux: listDocs[i]["Light"]["RedLux"].toDouble(),
                UV: listDocs[i]["Light"]["UV"],
                UVSource: listDocs[i]["Light"]["UVSource"],
                Sound: listDocs[i]["Sound"].toDouble()));
          }

          return listData;
        }
        else{
          return listData;
        }
      } else {
        return listData;
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      return [];
    }
  }

}