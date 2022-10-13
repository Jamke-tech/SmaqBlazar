import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class FloatLegend extends StatefulWidget {
  FloatLegend({super.key});

  @override
  State<FloatLegend> createState() => _FloatLegendState();
}

class _FloatLegendState extends State<FloatLegend> {
  final _formValidationKey = GlobalKey<FormState>();
  MapController mapController = MapController();
  Marker markerToDisplay = Marker(
      width: 30,
      height: 30,
      point: LatLng(41.35581, 2.14141),
      builder: (context) => Icon(
            Icons.location_on_outlined,
            color: Colors.red,
            size: 30,
          ));
  bool markerTapOrLocationSet = false;

  @override
  Widget build(BuildContext context) {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.zero,
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          border: Border.all(color: Colors.black, width: 2),
          color: Colors.grey.shade400, //Colors.lightGreen.shade800,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.7),
              spreadRadius: 2,
              blurRadius: 9,
              //offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.15,
        child: Column(
          children: [
            Row(

              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                    border: Border.all(width: 2, color: Colors.black),
                  ),
                ),
                Text(" BO "),

                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                    border: Border.all(width: 2, color: Colors.black),
                  ),
                ),
                Text(" Moderat")
              ],
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                    border: Border.all(width: 2, color: Colors.black),
                  ),
                ),
                Text(" Pobre"),

                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                    border: Border.all(width: 2, color: Colors.black),
                  ),
                ),
                Text(" Insalubre ")
              ],
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                    border: Border.all(width: 2, color: Colors.black),
                  ),
                ),
                Text(" Sever"),

                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                    border: Border.all(width: 2, color: Colors.black),
                  ),
                ),
                Text(" Perillós")
              ],
            ),
          ],
        ));
  }
}
