import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';

import '../classes/data_model.dart';
import '../classes/station_model.dart';
import '../services/Station_service.dart';
import '../widgets/Icon_map.dart';
import '../widgets/floating_add.dart';
import '../widgets/floating_info.dart';
import 'package:location/location.dart';

import '../widgets/floating_legend.dart';
import '../widgets/floating_position.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late LocationData locationData;
  late bool serviceEnabled;
  late PermissionStatus permissionGranted;
  Location userLocation = Location();
  MapController mapController = MapController();

  int _counter = 0;

  bool satellite = false;
  late StationModel stationShown = StationModel(
      name: "ERROR",
      IDStation: "ERROR",
      Description: "ERROR",
      lat: 0,
      long: 0,
      lastData: [],
      lastAQI: []);
  Color boxColor = Colors.lightGreen.shade800;
  Color AqiColor = Colors.lightGreen.shade800;
  bool addingStation = false;
  bool showingInfo = false;
  bool showingLegend = false;

  /*List<StationModel> StationList = [
    Station("AAD234", "", "", "FOC Wallbox Office", 41.35581, 2.14141, 223,
        25.6, 48.7, 1015.2),
    Station("AAD256", "", "", "Castell de Montjüic", 41.364879, 2.148868, 15,
        25.4, 49, 1014.2),
    Station("AAD523", "", "", "D26 Wallbox Factory", 41.32723, 2.12849, 110, 27,
        52.6, 1015.7),
    Station("AAD598", "", "", "Plaça Espanya", 41.37505, 2.14922, 172, 28, 51.5,
        1013.8)
  ];*/

  List<StationModel> StationList = [];

  List<Marker> markersList = [];

  @override
  void initState() {
    //Here we have to check location an consult infromation from BBDD
    //checkAndGetLocation();

    //We have to extract the data from the StationsList
    StationsManager stationsManager = StationsManager();
    StationList = stationsManager.listOfStations;
    //locationData= stationsManager.locationUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;
    markersList = [];
    //print(StationList[0]);
    for (StationModel station in StationList) {
      i++;
      print(station.lat);
      print(station.long);
      markersList.add(
        Marker(
            point: LatLng(station.lat, station.long),
            width: 20,
            height: 20,
            rotate: true,
            builder: (context) {
              //We have to set the color of the box
              int AqiLevel = station.getAQI();
              Color colorSelected = station.colorAQI(AqiLevel);

              return IconMap(
                Iconcolor: colorSelected,
                size: 10,
                setStateforMap: () {
                  //Fucntion to setState of map and change the values of the shown card
                  setState(() {
                    stationShown = station;
                    AqiColor = colorSelected;
                  });
                },
              );
            }),
      );
      print("marker ${i}");
    }

    return Scaffold(
      body: Stack(clipBehavior: Clip.hardEdge, fit: StackFit.expand, children: [
        Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FlutterMap(

                mapController: mapController,
                options: MapOptions(
                  onLongPress: (tapPosition, latLng){
                    setState(() {
                      stationShown = StationModel(
                          name: "ERROR",
                          IDStation: "ERROR",
                          Description: "ERROR",
                          lat: 0,
                          long: 0,
                          lastData: [],
                          lastAQI: []);




                    });
                  },
                    center: LatLng(markersList[0].point.latitude,
                        markersList[0].point.longitude),
                    minZoom: 2,
                    zoom: 14,
                    maxZoom: 20,
                    plugins: [
                      MarkerClusterPlugin(),
                    ]),
                /*nonRotatedChildren: [
              AttributionWidget.defaultWidget(
                source: 'OpenStreetMap contributors',
                onSourceTapped: null,
              ),
            ],*/
                layers: [
                  TileLayerOptions(
                    urlTemplate: satellite
                        ? 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}'
                        : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                    retinaMode: true,
                  ),
                  MarkerClusterLayerOptions(
                    maxClusterRadius: 120,
                    size: Size(30, 30),
                    fitBoundsOptions: FitBoundsOptions(
                      padding: EdgeInsets.all(40),
                    ),
                    //TODO This List is the stations list from the server ( Only get the near ones)
                    markers: markersList,

                    builder: (context, markers) {
                      return FloatingActionButton(
                        onPressed: null,
                        child: Text(markers.length.toString()),
                      );
                    },
                  ),
                  //LocationMarkerLayerOptions(),
                ]),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: showingInfo
                          ? (showingLegend
                              ? (const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.zero,
                                  bottomRight: Radius.circular(8)))
                              : (const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.zero)))
                          : BorderRadius.circular(8),
                      //border: Border.all(color: Colors.black, width: 1),
                      color: Colors.blueGrey.shade200, //Colors.grey.shade400,
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
                    height: 50,
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              color: (showingInfo && addingStation)
                                  ? Colors.grey.shade600
                                  : Colors.black,
                              onPressed: () {
                                if (!addingStation) {
                                  setState(() {
                                    if (showingInfo && showingLegend) {
                                      showingInfo = false;
                                    } else {
                                      showingInfo = true;
                                    }
                                    showingLegend = !showingLegend;
                                  });
                                }
                              },
                              icon: Icon(
                                  showingLegend
                                      ? Icons.close_outlined
                                      : Icons.info_outline_rounded,
                                  size: 30)),
                          IconButton(
                              onPressed: () {
                                if (!showingInfo) {
                                  setState(() {
                                    satellite = !satellite;
                                  });
                                }
                              },
                              icon: Icon(
                                  satellite
                                      ? Icons.map_rounded
                                      : Icons.satellite_rounded,
                                  size: 30,
                                  color: showingInfo
                                      ? Colors.grey.shade600
                                      : Colors.black)),
                          IconButton(
                              onPressed: () {
                                if (!showingInfo) {}
                              },
                              icon: Icon(Icons.filter_alt_rounded,
                                  size: 30,
                                  color: showingInfo
                                      ? Colors.grey.shade600
                                      : Colors.black)),
                          IconButton(
                              onPressed: () async {
                                if (!showingInfo) {
                                  //We have to refresh the information from the BBDD that we have
                                  StationsManager stationsManager =
                                      StationsManager();
                                  List<StationModel> listStations =
                                      await stationsManager
                                          .getAllStationsWithLastData();

                                  if (listStations.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('No hem pogut extreure les dades...')),
                                    );
                                  } else {
                                    setState(() {
                                      StationList = listStations;
                                      stationsManager.SaveStations(StationList);
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Informació de pantalla actualitzada')),
                                    );
                                  }
                                }
                              },
                              icon: Icon(Icons.refresh_outlined,
                                  size: 30,
                                  color: showingInfo
                                      ? Colors.grey.shade600
                                      : Colors.black)),
                          IconButton(
                              onPressed: () {
                                if (!showingLegend) {
                                  setState(() {
                                    if (showingInfo && addingStation) {
                                      showingInfo = false;
                                    } else {
                                      showingInfo = true;
                                    }
                                    addingStation = !addingStation;
                                  });
                                }
                              },
                              icon: Icon(
                                  addingStation
                                      ? Icons.close_outlined
                                      : Icons.add_box_outlined,
                                  size: 30,
                                  color: (showingInfo && showingLegend)
                                      ? Colors.grey.shade600
                                      : Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: showingInfo? Alignment.topCenter: Alignment.topRight,
                  child: Padding(
                    padding: showingInfo? const EdgeInsets.only(top: 10): const EdgeInsets.only(top: 20, right: 10),
                    child: showingInfo
                        ? (addingStation
                            ? FloatAdd()
                            : showingLegend
                                ? FloatLegend()
                                : Container())
                        :FloatPosition(
                      isRefresh: false,
                      functionWhenClicked: () async {
                        serviceEnabled = await userLocation.serviceEnabled();
                        if (!serviceEnabled) {
                          serviceEnabled =
                          await userLocation.requestService();
                          if (!serviceEnabled) {
                            return;
                          }
                        }
                        permissionGranted =
                        await userLocation.hasPermission();
                        if (permissionGranted == PermissionStatus.denied) {
                          permissionGranted =
                          await userLocation.requestPermission();
                          if (permissionGranted != PermissionStatus.granted) {
                            return;
                          }
                        }
                        locationData = await userLocation.getLocation();

                        setState(() {
                          mapController.move(
                              LatLng(locationData.latitude!,
                                  locationData.longitude!),
                              15);
                        });
                      },
                    ) ,
                  ),
                ),
              ],
            ),
          ),
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom:(16)),
            child: showingInfo && !showingLegend
                ? Container()
                : (stationShown.name == "ERROR"
                    ? Container()
                    : FloatInfo(
                        station: stationShown,
                        boxcolor: Colors.blueGrey.shade200,
                        AqiColor: AqiColor)),
          ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: 100,
                  child: Image.asset("assets/pictures/WBX_Brand_TM-Black.png")),
            ),
          ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: 130,
                  child: Image.asset("assets/pictures/marca_eetac_nova.png")),
            ),
          ),
        ),
      ]),
    );
  }
}
