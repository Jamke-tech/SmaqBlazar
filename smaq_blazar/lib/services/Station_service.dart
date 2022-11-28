import 'package:http/http.dart' as http;
import 'package:location_platform_interface/location_platform_interface.dart';
import 'dart:convert';

import '../api/endpoints.dart';
import '../classes/Model/data_model.dart';
import '../classes/Model/station_model.dart';
import 'Data_service.dart';
import 'package:location/location.dart';

class StationsManager {
  static final StationsManager _instance = StationsManager._internal();

  factory StationsManager() {
    return _instance;
  }

  StationsManager._internal() {
    // initialization logic
  }

  //Recuperem els endpoints de la clase
  Endpoints endpoints = Endpoints();

  List<StationModel> listOfStations= [];
  late LocationData locationUser;


  Future<void> SaveStations(List<StationModel> stations) async {
    listOfStations=stations;
  }

  //Function to create a new Station
  Future<bool> insertStation(StationModel station) async {
    try {
      print(station.IDStation);
      var headers = {
        'Content-Type': 'application/json',
        'api-key':
            endpoints.APIKey
      };
      var request = http.Request(
          'POST',
          Uri.parse(
              "${endpoints.MongoDB}/insertOne"));
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
      if (response.statusCode == 201 || response.statusCode == 200) {
        //Station upload correctly
        return false;
      } else {
        return true;
      }
    } catch (error) {
      print(error);
      return true;
    }
  }

  Future<List<StationModel>> getAllStationsWithLastData() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'api-key':
            endpoints.APIKey
      };
      var request = http.Request(
          'POST',
          Uri.parse(
              "${endpoints.MongoDB}/find"));
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
      if (response.statusCode == 200) {
        DataManager dataManager = DataManager();
        var realResponse = await http.Response.fromStream(response);
        List<dynamic> StationList = jsonDecode(realResponse.body)["documents"];
        List<StationModel> stationsReturn = [];
        //print(StationList);

        for (var station in StationList) {
          //print("Station number: ${station["StationID"]}");
          List<DataStation> dataForThatStation =
              await dataManager.getDataStation(station["StationID"]);
          //print(dataForThatStation);

          StationModel stationModel = StationModel(
              name: station["name"],
              IDStation: station["StationID"],
              Description: station["description"],
              lat: station["lat"],
              long: station["long"],
              lastData: dataForThatStation,lastAQI:[]);

          //print("Compute AQI: ");
          if(stationModel.lastData.isNotEmpty) {
            stationModel.computeAQI(DateTime.parse(
                stationModel.lastData[0].CreationDate.replaceAll("/", "-")));
          }else{
            stationModel.lastAQI=[];
          }
          //print(stationModel.lastAQI);

          stationsReturn.add(stationModel);
        }

        //Station upload correctly
        return stationsReturn;
      } else {
        return [];
      }
    } catch (error) {
      print(error);
      return [];
    }
  }

  saveLocation(LocationData locationData) {
    locationUser=locationData;
  }
}
