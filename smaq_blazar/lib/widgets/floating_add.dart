

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class FloatAdd extends StatefulWidget {
  FloatAdd({super.key});

  @override
  State<FloatAdd> createState() => _FloatAddState();
}

class _FloatAddState extends State<FloatAdd> {
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
              topLeft: Radius.circular(20),
              topRight: Radius.zero,
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
        height: MediaQuery.of(context).size.height * 0.50,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formValidationKey,
              child: Column(
                children: [
                  Text("Station ID: "),
                  Divider(
                    color: Colors.black,
                    height: 2,
                    thickness: 2,
                    indent: 10,
                    endIndent: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Falta un nom vàlid';
                      }
                      return null;
                    },
                  ),
                  Text("Station Nikname: "),
                  Divider(
                    color: Colors.black,
                    height: 2,
                    thickness: 2,
                    indent: 10,
                    endIndent: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Falta un nom vàlid';
                      }
                      return null;
                    },
                  ),
                  /*Text("Description: "),
                Divider(
                  color: Colors.black,
                  height: 2,
                  thickness: 2,
                  indent: 10,
                  endIndent: 10,
                ),
                TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Falta un nom vàlid';
                    }
                    return null;

                  },
                ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Location: "),

                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    height: 2,
                    thickness: 2,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Container(
                      height: 150,
                      child: Stack(
                        children: [
                          FlutterMap(
                              mapController: mapController,
                              options: MapOptions(
                                  center: LatLng(41.35581, 2.14141),
                                  minZoom: 5,
                                  zoom: 14,
                                  plugins: [
                                    MarkerClusterPlugin(),
                                  ],
                                  onLongPress: (tapPosition, latlng) {
                                    setState(() {
                                      markerToDisplay =
                                          Marker(
                                              width: 30,
                                              height: 30,
                                              point: latlng,
                                              builder: (context) => Icon(
                                                Icons.location_on_outlined,
                                                color: Colors.red,
                                                size: 30,
                                              ));

                                      markerTapOrLocationSet=true;

                                    });
                                  }),
                              layers: [
                                TileLayerOptions(
                                  urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  subdomains: ['a', 'b', 'c'],
                                  retinaMode: true,
                                ),
                                MarkerLayerOptions(markers: markerTapOrLocationSet? ([ markerToDisplay] ): [] ),
                              ]),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey.shade600,
                                    fixedSize: Size(10,10),


                                  ),
                                  onPressed: () async {
                                    _serviceEnabled = await location.serviceEnabled();
                                    if (!_serviceEnabled) {
                                      _serviceEnabled = await location.requestService();
                                      if (!_serviceEnabled) {
                                        return;
                                      }
                                    }
                                    _permissionGranted = await location.hasPermission();
                                    if (_permissionGranted == PermissionStatus.denied) {
                                      _permissionGranted =
                                      await location.requestPermission();
                                      if (_permissionGranted !=
                                          PermissionStatus.granted) {
                                        return;
                                      }
                                    }
                                    _locationData = await location.getLocation();


                                    markerToDisplay =
                                        Marker(
                                            width: 30,
                                            height: 30,
                                            point: LatLng(_locationData.latitude!, _locationData.longitude!),
                                            builder: (context) => Icon(
                                              Icons.location_on_outlined,
                                              color: Colors.red,
                                              size: 30,
                                            ));
                                    setState((){
                                      markerTapOrLocationSet=true;
                                    });

                                  },
                                  child: Icon(Icons.my_location,size: 25,
                                    color: Colors.white,)),
                            ),
                          ),
                        ]
                      ),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade600,
                      ),
                      onPressed: () {
                        //We validate the form
                        if (_formValidationKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Saving Data')),
                          );
                          //TODO save the data in a server

                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.save,
                            size: 30,
                            color: Colors.white,),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text( "SAVE",
                                style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                          ),
                        ],
                      ))
                ],
              ),
            )));
  }
}
