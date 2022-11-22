import 'package:SMAQ/classes/Model/all_state.dart';
import 'package:http/http.dart' as http;
import 'package:location_platform_interface/location_platform_interface.dart';
import 'dart:convert';

import '../api/endpoints.dart';
import '../classes/Model/data_model.dart';
import '../classes/Model/station_model.dart';
import 'Data_service.dart';
import 'package:location/location.dart';

class FlightService {
  //Service to get Flight information from Open Sky
  Endpoints endpoints = Endpoints();

  Future<List<AllState>> getFlightWithinBounds(
      double latMin, double latMax, double longMin, double longMax) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'GET',
          Uri.parse(
              "${endpoints.APIFlights}/states/all?lamin=$latMin&lomin=$longMin&lamax=$latMax&lomax=$longMax"));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      print(response.statusCode);
      if (response.statusCode == 200) {
        var realResponse = await http.Response.fromStream(response);
        //print(jsonDecode(realResponse.body)["states"]);
        List<AllState> flightsData =
            (jsonDecode(realResponse.body)["states"] as List)
                .map((e) => AllState.fromJson(e))
                .toList();

        return flightsData;
      } else {
        return [];
      }
    } catch (error) {
      print(error);
      return [];
    }
  }
}
