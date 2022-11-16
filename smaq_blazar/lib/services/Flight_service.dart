import 'package:SMAQ/classes/Model/all_state.dart';
import 'package:http/http.dart' as http;
import 'package:location_platform_interface/location_platform_interface.dart';
import 'dart:convert';

import '../api/endpoints.dart';
import '../classes/Model/data_model.dart';
import '../classes/Model/station_model.dart';
import 'Data_service.dart';
import 'package:location/location.dart';

class FlightService{
  //Service to get Flight information from Open Sky


  /*Future<List<AllState>> getAllStationsWithLastData() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'api-key':
        'MZpxcJNBp1UMJ8JGdnbH5lhR7sAt3CEiREyVlyfEjFkZBD6vuhE960x9TmQD5GHs'
      };
      var request = http.Request(
          'POST',
          Uri.parse(
              'https://data.mongodb-api.com/app/data-ugjsw/endpoint/data/v1/action/find'));
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
  }*/












}