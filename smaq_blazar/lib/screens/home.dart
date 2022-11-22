import 'package:SMAQ/classes/Model/all_state.dart';
import 'package:SMAQ/services/Flight_service.dart';
import 'package:SMAQ/widgets/floating_plane_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:vector_math/vector_math.dart' as Converter;

import '../classes/Model/data_model.dart';
import '../classes/Model/station_model.dart';
import '../services/Station_service.dart';
import '../widgets/Icon_map.dart';
import '../widgets/floating_add.dart';
import '../widgets/floating_filter.dart';
import '../widgets/floating_info.dart';
import 'package:location/location.dart';

import '../widgets/floating_legend.dart';
import '../widgets/floating_position.dart';


class Home extends StatefulWidget {
  LocationData locationData;
  Home({super.key, required this.locationData});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late bool serviceEnabled;
  bool planeClicked = false;
  late PermissionStatus permissionGranted;
  Location userLocation = Location();
  MapController mapController = MapController();


  bool satellite = false;
  late StationModel stationShown = StationModel(
      name: "ERROR",
      IDStation: "ERROR",
      Description: "ERROR",
      lat: 0,
      long: 0,
      lastData: [],
      lastAQI: []);
  late AllState flightShown = AllState(
    icao24:"000",
    callSign:"NONE",
    origin:"CATALONIA",
    timePosition:0,
    long:0,
    lat:0,
    baroAltitude:-1,
    trueTrack: 0,
    onGround:true,
    geoAltitude:-1,
    verticalVel: 0,
    horizontalVel: 0,
  );
  Color boxColor = Colors.lightGreen.shade800;
  Color AqiColor = Colors.lightGreen.shade800;
  bool addingStation = false;
  bool showingInfo = false;
  bool showingLegend = false;
  bool showingFilter= false;
  bool isAPlane=false;


  List<StationModel> StationList = [];
  List<AllState> flightsShowing = [];

  List<Marker> markersList = [];
  List<Marker> markersForFlights = [];

  List<Marker> markersToShow = [];

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
    markersList = [];
    markersForFlights = [];
    markersToShow = [];

    for (StationModel station in StationList) {
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
                    isAPlane = false;
                  });
                },
              );
            }),
      );

    }
    for (AllState flight in flightsShowing) {

      if(flight.baroAltitude<=2500) {
        markersForFlights.add(
          Marker(
              point: LatLng(flight.lat, flight.long),
              width: 20,
              height: 20,
              rotate: false,
              builder: (context) {
                if (flight.icao24 == flightShown.icao24) {

                }


                return Transform.rotate(
                    angle: Converter.radians(flight.trueTrack),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          flightShown = flight;
                          isAPlane = true;
                        });
                      },
                      child: Icon(Icons.airplanemode_on_rounded,
                        color: flight.icao24 == flightShown.icao24
                            ? Colors.black
                            : flight.getFlightColor(),


                      ),
                    ));
              }),
        );
      }

    }

    if(planeClicked){
      markersToShow.addAll(markersList);
      markersToShow.addAll(markersForFlights);
    }else{
      markersToShow.addAll(markersList);
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
                    onLongPress: (tapPosition, latLng) {
                      setState(() {
                        stationShown = StationModel(
                            name: "ERROR",
                            IDStation: "ERROR",
                            Description: "ERROR",
                            lat: 0,
                            long: 0,
                            lastData: [],
                            lastAQI: []);
                        isAPlane=false;
                      });
                    },
                    center: LatLng(widget.locationData.latitude!,widget.locationData.longitude!),//LatLng(markersList[0].point.latitude,markersList[0].point.longitude),
                    minZoom: 2,
                    zoom: 14,
                    maxZoom: 20,
                    plugins: [
                      MarkerClusterPlugin(),
                    ]),

                layers: [
                  TileLayerOptions(
                    urlTemplate: satellite
                        ? 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}'
                        : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                    retinaMode: true,
                  ),
                  MarkerClusterLayerOptions(
                    maxClusterRadius: 20,
                    size: const Size(30, 30),
                    fitBoundsOptions: const FitBoundsOptions(
                      padding: EdgeInsets.all(40),
                    ),

                    markers: markersToShow,

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

                              onPressed: () {
                                if (!addingStation && !showingFilter) {
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
                                  size: 30,
                                color: (showingInfo && (showingFilter || addingStation))
                                    ? Colors.grey.shade600
                                    : Colors.black,)),
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
                                if (!showingLegend && !addingStation) {
                                  setState(() {
                                    //Modificamos el estado de showing Info
                                    if (showingInfo && showingFilter) {
                                      showingInfo = false;
                                    } else {
                                      showingInfo = true;
                                    }
                                    showingFilter= !showingFilter;
                                  });
                                }
                              },
                              icon: Icon(showingFilter
                                  ? Icons.close_outlined:Icons.filter_alt_rounded,
                                  size: 30,
                                  color: (showingInfo && (showingLegend || addingStation))
                                      ? Colors.grey.shade600
                                      : Colors.black)),
                          IconButton(
                              onPressed: () async {
                                if (!showingInfo) {
                                  //We have to refresh the information from the BBDD that we have
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Extraïent nova informació dels SMAQ's ...")),
                                  );

                                  FlightService flights = FlightService();
                                  List<AllState> flightsToShow = flightsShowing;
                                  if(planeClicked) {
                                    //We need to refresh the data of the flight when we clicked to see them
                                    flightsToShow = [];
                                    flightsToShow = await flights.getFlightWithinBounds(
                                        mapController.center.latitude - 0.8,
                                        mapController.center.latitude + 0.8,
                                        mapController.center.longitude - 0.8,
                                        mapController.center.longitude + 0.8);
                                  }


                                  StationsManager stationsManager =
                                  StationsManager();
                                  List<StationModel> listStations =
                                  await stationsManager
                                      .getAllStationsWithLastData();

                                  if (listStations.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'No hem pogut extreure les dades...')),
                                    );
                                  } else {
                                    //We have to search the same Station ID that we have been selected before and reshow
                                    setState(() {
                                      bool found = false;
                                      int positionStation = 0;
                                      while (!found &&
                                          positionStation <
                                              listStations.length) {
                                        if (listStations[positionStation]
                                                .IDStation ==
                                            stationShown.IDStation) {
                                          //We have found the station and we have to refresh the data
                                          stationShown =
                                              listStations[positionStation];
                                          found = true;
                                        }
                                        positionStation++;
                                      }
                                      StationList = listStations;
                                      stationsManager.SaveStations(StationList);

                                      //actualitzem dades de vols

                                      bool foundPlane = false;
                                      int positionPlane = 0;
                                      while (!foundPlane &&
                                          positionPlane <
                                              flightsToShow.length) {
                                        if (flightsToShow[positionPlane]
                                            .icao24 ==
                                            flightShown.icao24) {
                                          //We have found the station and we have to refresh the data
                                          flightShown =
                                          flightsToShow[positionPlane];
                                          found = true;
                                        }
                                        positionPlane++;
                                      }

                                      flightsShowing=flightsToShow;
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
                                if (!showingLegend && !showingFilter) {
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
                                  color: (showingInfo && (showingLegend || showingFilter))
                                      ? Colors.grey.shade600
                                      : Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment:
                      showingInfo ? Alignment.topCenter : Alignment.topRight,
                  child: Padding(
                    padding: showingInfo
                        ? const EdgeInsets.only(top: 10)
                        : const EdgeInsets.only(top: 20, right: 10),
                    child: showingInfo
                        ? (addingStation
                            ? FloatAdd()
                            : showingLegend
                                ? FloatLegend()
                                : showingFilter ?FloatFilter(functionWhenFilterChanged: (int Filter) {
                    },) :Container())
                        : FloatPosition(
                        isPlaneOff: true,
                          isPlane: false,
                          functionWhenClicked: () async {
                            serviceEnabled =
                            await userLocation.serviceEnabled();
                            if (!serviceEnabled) {
                              serviceEnabled =
                              await userLocation.requestService();
                              if (!serviceEnabled) {
                                return;
                              }
                            }
                            permissionGranted =
                            await userLocation.hasPermission();
                            if (permissionGranted ==
                                PermissionStatus.denied) {
                              permissionGranted =
                              await userLocation.requestPermission();
                              if (permissionGranted !=
                                  PermissionStatus.granted) {
                                return;
                              }
                            }
                            widget.locationData = await userLocation.getLocation();

                            setState(() {
                              mapController.move(
                                  LatLng(widget.locationData.latitude!,
                                      widget.locationData.longitude!),
                                  15);
                            });
                          },
                        )
                  ),
                ),
                Align(
                  alignment:
                  showingInfo ? Alignment.topCenter : Alignment.topRight,
                  child: Padding(
                      padding: showingInfo
                          ? const EdgeInsets.only(top: 10)
                          : const EdgeInsets.only(top: 10, right: 10),
                      child: showingInfo
                          ? (addingStation
                          ? Container()
                          : showingLegend
                          ? Container()
                          : showingFilter ?FloatFilter(functionWhenFilterChanged: (int Filter) {
                      },) :Container())
                          : FloatPosition(
                            isPlaneOff: planeClicked,
                            isPlane: true,
                            functionWhenClicked: () async {

                              FlightService flights = FlightService();
                              print(planeClicked);
                              List<AllState> flightsToShow = [];
                              if(!planeClicked) {
                                //We need to refresh the data of the flight when we clicked to see them
                                 flightsToShow = await flights.getFlightWithinBounds(
                                    mapController.center.latitude - 0.8,
                                    mapController.center.latitude + 0.8,
                                    mapController.center.longitude - 0.8,
                                    mapController.center.longitude + 0.8);
                              }else{
                                flightsToShow = [];
                              }
                              //print(flightsToShow[0].icao24);
                              setState(() {
                                planeClicked = !planeClicked;
                                flightsShowing=flightsToShow;
                              });

                            },
                          )
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: (16)),
            child: showingInfo && addingStation
                ? Container()
                : ((stationShown.name == "ERROR" && !isAPlane)
                    ? Container()
                    : isAPlane ? FloatPlaneInfo(flight: flightShown): FloatInfo(
                        station: stationShown,
                        boxColor: Colors.blueGrey.shade200)),
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
