import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../api/endpoints.dart';
import '../classes/Model/data_model.dart';
import '../classes/Model/station_model.dart';

class DataManager {
  static final DataManager _instance = DataManager._internal();

  factory DataManager() {
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
        'api-key':
            endpoints.APIKey,
      };
      var request = http.Request(
          'POST',
          Uri.parse("${endpoints.MongoDB}/find"));
      request.body = json.encode({
        "dataSource": endpoints.MongoDbCluster,
        "database": endpoints.DataBaseName,
        "collection": endpoints.MongoDbCollectionDataCollected,
        "filter": {"StationID": IDStation},
        "sort": {
          "CreationDate": -1, //We want the last data value
        },
        "limit": 408, //Són dades de 24h en teoria com a màxim + 10h per si fem el historial
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      print(response.statusCode);
      List<DataStation> listData = [];
      if (response.statusCode == 200) {
        var realResponse = await http.Response.fromStream(response);
        List<dynamic> listDocs = jsonDecode(realResponse.body)["documents"];

        if (listDocs.isNotEmpty) {

          for (int i = 0; i < listDocs.length; i++) {
            //We add to the vector the value in decendant order

            //To solve some errors on contaminations measuring
            double SO2 =
                (listDocs[i]["Pollutants"]["CxSO2"].toDouble() / 1000); //-0.7;
            if (SO2 > 1.004) {
              //eliminem pics
              while(SO2>1.004){
                SO2 = SO2-1.004;
              }
              SO2 = SO2-1.004;
            }
            SO2 = SO2 * 0.3;

            if (SO2 > 0.7) {
              SO2 = SO2 - 1.5;
            }
            if (SO2 < 0) {
              SO2 = 0;
            }
            double NO2 =
                (listDocs[i]["Pollutants"]["CxNO2"].toDouble() / 1000); //-0.5;
            if (NO2 > 2.049) {
              //eliminem pics
              while(NO2>2.049){
                NO2 = NO2-2.049;
              }

            }
            NO2 = (NO2 * 0.4)-0.25;

            if (NO2 > 0.4) {
              NO2 = NO2 - 1.1;
            }
            if (NO2 < 0) {
              NO2 = 0;
            }
            double O3 = ((listDocs[i]["Pollutants"]["CxO3"].toDouble() /
                1000)); //-0.001;
            if (O3 > 0.604) {
              //eliminem pics
              while(O3>0.604){
                O3 = O3-0.604;
              }
            }
            O3 = (O3 * 0.7) - 0.4;

            if (O3 < 0) {
              O3 = 0;
            }
            double CO = ((listDocs[i]["Pollutants"]["CxCO"].toDouble() /
                1000)); //-0.001;
            CO = (CO * 0.7) - 5;
            if (CO < 0) {
              CO = 0;
            }

            listData.add(DataStation(
                StationID: listDocs[i]["StationID"],
                CreationDate: listDocs[i]["CreationDate"],
                Humidity: listDocs[i]["Weather"]["Humidity"].toDouble(),
                Temperature: listDocs[i]["Weather"]["Temperature"].toDouble(),
                Pressure: listDocs[i]["Weather"]["Pressure"].toDouble(),
                Rain: listDocs[i]["Weather"]["Rain"].toDouble(),
                //As we save the pollutants in ppb we have to divide the ppb by 1000 to get ppm
                CxCO: CO,
                CxNO2: NO2,
                CxO3: O3,
                CxSO2: SO2,
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
        } else {
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
