import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import '../classes/data_model.dart';
import '../classes/station_model.dart';
import '../services/Station_service.dart';

class FloatAdd extends StatefulWidget {
  FloatAdd({super.key});

  @override
  State<FloatAdd> createState() => _FloatAddState();
}

class _FloatAddState extends State<FloatAdd> {
  final _formValidationKey = GlobalKey<FormState>();
  MapController mapController = MapController();
  TextEditingController IDStation = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController Description = TextEditingController();
  LatLng CenterLocation = LatLng(41.35581, 2.14141);

  Marker markerToDisplay = Marker(
      width: 30,
      height: 30,
      point: LatLng(41.35581, 2.14141),
      builder: (context) => const Icon(
            Icons.location_on_outlined,
            color: Colors.red,
            size: 30,
          ));
  bool markerTapOrLocationSet = false;

  @override
  Widget build(BuildContext context) {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.zero,
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8)),
          //border: Border.all(color: Colors.black, width: 1),
          color: Colors.blueGrey.shade200, //Colors.lightGreen.shade800,
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
        //height: MediaQuery.of(context).size.height * 0.50,
        child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Form(
              key: _formValidationKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text("ID estació: ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      Expanded(
                        child: TextFormField(
                          controller: IDStation,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Falta un nom vàlid';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black,
                    height: 4,
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                  ),
                  Row(
                    children: [
                      const Text("Nom: ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      Expanded(
                        child: TextFormField(
                          controller: name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Falta un nom vàlid';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black,
                    height: 4,
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                  ),
                  Row(
                    children: [
                      const Text("Descripció: ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      Expanded(
                        child: TextFormField(
                          controller: Description,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Falta un nom vàlid';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black,
                    height: 4,
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                  ),
                  const Text("Localització: ",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),

                  /*Divider(
                    color: Colors.black,
                    height: 2,
                    thickness: 2,
                    indent: 10,
                    endIndent: 10,
                  ),*/
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: Container(
                      height: 120,
                      child: Stack(children: [
                        FlutterMap(
                            mapController: mapController,
                            options: MapOptions(
                                center: CenterLocation,
                                //LatLng(41.35581, 2.14141),
                                minZoom: 5,
                                zoom: 14,
                                plugins: [
                                  MarkerClusterPlugin(),
                                ],
                                onLongPress: (tapPosition, latlng) {
                                  setState(() {
                                    markerToDisplay = Marker(
                                        width: 30,
                                        height: 30,
                                        point: latlng,
                                        builder: (context) => const Icon(
                                              Icons.location_on_outlined,
                                              color: Colors.black,
                                              size: 20,
                                            ));

                                    markerTapOrLocationSet = true;
                                    CenterLocation = LatLng(
                                        latlng.latitude, latlng.longitude);
                                    mapController.move(CenterLocation, 15);
                                  });
                                }),
                            layers: [
                              TileLayerOptions(
                                urlTemplate:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                subdomains: ['a', 'b', 'c'],
                                retinaMode: true,
                              ),
                              MarkerLayerOptions(
                                  markers: markerTapOrLocationSet
                                      ? ([markerToDisplay])
                                      : []),
                            ]),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade600,
                                  fixedSize: Size(10, 10),
                                ),
                                onPressed: () async {
                                  serviceEnabled =
                                      await location.serviceEnabled();
                                  if (!serviceEnabled) {
                                    serviceEnabled =
                                        await location.requestService();
                                    if (!serviceEnabled) {
                                      return;
                                    }
                                  }
                                  permissionGranted =
                                      await location.hasPermission();
                                  if (permissionGranted ==
                                      PermissionStatus.denied) {
                                    permissionGranted =
                                        await location.requestPermission();
                                    if (permissionGranted !=
                                        PermissionStatus.granted) {
                                      return;
                                    }
                                  }
                                  locationData = await location.getLocation();

                                  markerToDisplay = Marker(
                                      width: 30,
                                      height: 30,
                                      point: LatLng(locationData.latitude!,
                                          locationData.longitude!),
                                      builder: (context) => const Icon(
                                            Icons.location_on_outlined,
                                            color: Colors.black,
                                            size: 20,
                                          ));
                                  setState(() {
                                    markerTapOrLocationSet = true;
                                    CenterLocation = LatLng(
                                        locationData.latitude!,
                                        locationData.longitude!);
                                    mapController.move(CenterLocation, 15);
                                  });
                                },
                                child: const Icon(
                                  Icons.my_location,
                                  size: 25,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade600,
                      ),
                      onPressed: () async {
                        //We validate the form
                        if (_formValidationKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Guardant dades al núvol ...')),
                          );

                          StationsManager stationsManager = StationsManager();

                          bool isAnError =
                              await stationsManager.insertStation(StationModel(
                            name: name.text.toString(),
                            IDStation: IDStation.text.toString(),
                            Description: Description.text.toString(),
                            lat: markerToDisplay.point.latitude,
                            long: markerToDisplay.point.longitude,
                            lastData: [],
                            lastAQI: [],
                          ));
                          if (isAnError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Error en guardar')),
                            );
                            setState(() {});
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Estació guardada amb éxit, ja pots tancar la finestra.')),
                            );
                          }

                          //TODO save the data in a server

                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.save,
                            size: 20,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text("Guardar estació",
                                style: TextStyle(
                                    fontSize: 15,
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
