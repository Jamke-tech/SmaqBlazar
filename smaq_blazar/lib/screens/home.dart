import 'package:SMAQ/classes/Model/all_state.dart';
import 'package:SMAQ/classes/helpers/design_helper.dart';
import 'package:SMAQ/services/Flight_service.dart';
import 'package:SMAQ/widgets/info_cards/floating_plane_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:vector_math/vector_math.dart' as converter_math;
import '../classes/Model/station_model.dart';
import '../services/Station_service.dart';
import '../widgets/map_markers/Icon_map.dart';
import '../widgets/home_bar/floating_add.dart';
import '../widgets/home_bar/floating_filter.dart';
import '../widgets/info_cards/floating_info.dart';
import 'package:location/location.dart';
import '../widgets/home_bar/floating_legend.dart';
import '../widgets/floating_action_buttons/floating_position.dart';

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
    icao24: "000",
    callSign: "NONE",
    origin: "CATALONIA",
    timePosition: 0,
    long: 0,
    lat: 0,
    baroAltitude: -1,
    trueTrack: 0,
    onGround: true,
    geoAltitude: -1,
    verticalVel: 0,
    horizontalVel: 0,
  );
  Color boxColor = Colors.lightGreen.shade800;
  Color aqiColor = Colors.lightGreen.shade800;
  bool addingStation = false;
  bool showingInfo = false;
  bool showingLegend = false;
  bool showingFilter = false;
  bool isAPlane = false;
  bool filterSelected = false;

  List<StationModel> stationList = [];
  List<AllState> flightsShowing = [];
  List<Marker> markersList = [];
  List<Marker> markersFilterGeneralList = [];
  List<Marker> markersForFlights = [];
  List<Marker> markersToShow = [];

  DesignHelper design = DesignHelper();


  @override
  void initState() {
    //Here we have to check location an consult infromation from BBDD
    //checkAndGetLocation();

    //We have to extract the data from the StationsList
    StationsManager stationsManager = StationsManager();
    stationList = stationsManager.listOfStations;
    //locationData= stationsManager.locationUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    if (!filterSelected) {
      markersList = [];
      markersForFlights = [];
      markersToShow = [];

      for (StationModel station in stationList) {
        //print(station.lat);
        //print(station.long);
        markersList.add(
          Marker(
              point: LatLng(station.lat, station.long),
              width: 20,
              height: 20,
              rotate: true,
              builder: (context) {
                //We have to set the color of the box
                int aqiLevel = station.getAQI();
                Color colorSelected = design.colorAQI(aqiLevel);

                return IconMap(
                  borderColor: stationShown.IDStation==station.IDStation ? const Color(0xff8CE0B0) : Colors.black,
                  iconColor: colorSelected,
                  size: 10,
                  setStateforMap: () {
                    //Fucntion to setState of map and change the values of the shown card
                    setState(() {
                      stationShown = station;
                      aqiColor = colorSelected;
                      isAPlane = false;
                    });
                  },
                );
              }),
        );
      }
      for (AllState flight in flightsShowing) {
        if (flight.baroAltitude <= 2500) {
          markersForFlights.add(
            Marker(
                point: LatLng(flight.lat, flight.long),
                width: 20,
                height: 20,
                rotate: false,
                builder: (context) {
                  if (flight.icao24 == flightShown.icao24) {}

                  return Transform.rotate(
                      angle: converter_math.radians(flight.trueTrack),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            flightShown = flight;
                            isAPlane = true;
                          });
                        },
                        child: Icon(
                          Icons.airplanemode_on_rounded,
                          color: flight.icao24 == flightShown.icao24
                              ? Colors.black
                              : flight.getFlightColor(),
                        ),
                      ));
                }),
          );
        }
      }

      if (planeClicked) {
        markersToShow.addAll(markersList);
        markersToShow.addAll(markersForFlights);
      } else {
        markersToShow.addAll(markersList);
      }
    } else if (planeClicked) {
      markersToShow = [];
      markersForFlights = [];
      for (AllState flight in flightsShowing) {
        if (flight.baroAltitude <= 2500) {
          markersForFlights.add(
            Marker(
                point: LatLng(flight.lat, flight.long),
                width: 20,
                height: 20,
                rotate: false,
                builder: (context) {
                  if (flight.icao24 == flightShown.icao24) {}

                  return Transform.rotate(
                      angle: converter_math.radians(flight.trueTrack),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            flightShown = flight;
                            isAPlane = true;
                          });
                        },
                        child: Icon(
                          Icons.airplanemode_on_rounded,
                          color: flight.icao24 == flightShown.icao24
                              ? Colors.black
                              : flight.getFlightColor(),
                        ),
                      ));
                }),
          );
        }
      }
      //}
      markersToShow.addAll(markersForFlights);
      markersToShow.addAll(markersFilterGeneralList);
    } else if (!planeClicked) {
      markersToShow = [];
      //We do not have planes clicked so we need to erase the planes from de markers list
      markersToShow.addAll(markersFilterGeneralList);
    }





    return Scaffold(
      body: Stack(clipBehavior: Clip.hardEdge, fit: StackFit.expand, children: [
        Center(
          child: SizedBox(
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
                        isAPlane = false;
                      });
                    },
                    center: LatLng(widget.locationData.latitude!,
                        widget.locationData.longitude!),
                    //LatLng(markersList[0].point.latitude,markersList[0].point.longitude),
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
                    maxClusterRadius: planeClicked ? 20 : 40,
                    size: const Size(25, 25),
                    fitBoundsOptions: const FitBoundsOptions(
                      padding: EdgeInsets.all(40),
                    ),
                    markers: markersToShow,
                    builder: (context, markers) {
                      return FloatingActionButton(
                        backgroundColor: Colors.blueGrey.shade200,
                        heroTag: "BANANAAAA",
                        onPressed: null,
                        child: Text(markers.length.toString(), style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        ),),
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
                  padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
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
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 9,
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
                                color: (showingInfo &&
                                        (showingFilter || addingStation))
                                    ? Colors.grey.shade600
                                    : Colors.black,
                              )),
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
                                    showingFilter = !showingFilter;
                                  });
                                }
                              },
                              icon: Icon(
                                  showingFilter
                                      ? Icons.close_outlined
                                      : Icons.filter_alt_rounded,
                                  size: 30,
                                  color: (showingInfo &&
                                          (showingLegend || addingStation))
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
                                  if (planeClicked) {
                                    //We need to refresh the data of the flight when we clicked to see them
                                    flightsToShow = [];
                                    flightsToShow =
                                        await flights.getFlightWithinBounds(
                                            mapController.center.latitude - 0.8,
                                            mapController.center.latitude + 0.8,
                                            mapController.center.longitude -
                                                0.8,
                                            mapController.center.longitude +
                                                0.8);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Extraïent nova informació dels avions ...")),
                                    );
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
                                      stationList = listStations;
                                      stationsManager.SaveStations(stationList);

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

                                      flightsShowing = flightsToShow;
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
                                  color: (showingInfo &&
                                          (showingLegend || showingFilter))
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
                                  : showingFilter
                                      ? FloatFilter(
                                          functionWhenFilterChanged:
                                              (int filter,
                                                  String selectedMethod) {
                                            //Function to apply the filter when we change the value
                                            //we need to remake the makers list in order to only show the markers with desired value
                                            double AQIlevelmax = 50;
                                            double AQIlevelmin = -2;
                                            switch (filter) {
                                              case 0:
                                                AQIlevelmax = 50;
                                                AQIlevelmin = -2;
                                                break;
                                              case 1:
                                                AQIlevelmax = 100;
                                                AQIlevelmin = 50;
                                                break;
                                              case 2:
                                                AQIlevelmax = 150;
                                                AQIlevelmin = 100;
                                                break;
                                              case 3:
                                                AQIlevelmax = 200;
                                                AQIlevelmin = 150;
                                                break;
                                              case 4:
                                                AQIlevelmax = 300;
                                                AQIlevelmin = 200;
                                                break;
                                              case 5:
                                                AQIlevelmax = 500;
                                                AQIlevelmin = 300;
                                                break;
                                              default:
                                                AQIlevelmax = 50;
                                                AQIlevelmin = -2;
                                                break;
                                            }
                                            setState(() {
                                              List<Marker> markersFilterList =
                                                  [];

                                              //markersToShow = [];
                                              for (StationModel station
                                                  in stationList) {
                                                if (selectedMethod ==
                                                    "Múltiple") {
                                                  if (station.getAQI() <=
                                                      AQIlevelmax) {
                                                    markersFilterList.add(
                                                      Marker(
                                                          point: LatLng(
                                                              station.lat,
                                                              station.long),
                                                          width: 20,
                                                          height: 20,
                                                          rotate: true,
                                                          builder: (context) {
                                                            //We have to set the color of the box
                                                            int AqiLevel =
                                                                station
                                                                    .getAQI();
                                                            Color
                                                                colorSelected =
                                                            design.colorAQI(
                                                                    AqiLevel);

                                                            return IconMap(
                                                              iconColor:
                                                                  colorSelected,
                                                              borderColor: stationShown.IDStation==station.IDStation ? const Color(0xff8CE0B0) : Colors.black,
                                                              size: 10,
                                                              setStateforMap:
                                                                  () {
                                                                //Fucntion to setState of map and change the values of the shown card
                                                                setState(() {
                                                                  stationShown =
                                                                      station;
                                                                  aqiColor =
                                                                      colorSelected;
                                                                  isAPlane =
                                                                      false;
                                                                });
                                                              },
                                                            );
                                                          }),
                                                    );
                                                  }
                                                } else {
                                                  if (station.getAQI() <=
                                                          AQIlevelmax &&
                                                      station.getAQI() >
                                                          AQIlevelmin) {
                                                    markersFilterList.add(
                                                      Marker(
                                                          point: LatLng(
                                                              station.lat,
                                                              station.long),
                                                          width: 20,
                                                          height: 20,
                                                          rotate: true,
                                                          builder: (context) {
                                                            //We have to set the color of the box
                                                            int aqiLevel =
                                                                station
                                                                    .getAQI();
                                                            Color
                                                                colorSelected =
                                                            design.colorAQI(
                                                                    aqiLevel);

                                                            return IconMap(
                                                              iconColor:
                                                                  colorSelected,
                                                              borderColor: stationShown.IDStation==station.IDStation ? const Color(0xff8CE0B0) : Colors.black,
                                                              size: 10,
                                                              setStateforMap:
                                                                  () {
                                                                //Fucntion to setState of map and change the values of the shown card
                                                                setState(() {
                                                                  stationShown =
                                                                      station;
                                                                  aqiColor =
                                                                      colorSelected;
                                                                  isAPlane =
                                                                      false;
                                                                });
                                                              },
                                                            );
                                                          }),
                                                    );
                                                  }
                                                }
                                              }

                                              markersFilterGeneralList =
                                                  markersFilterList;

                                              /*print(
                                                  "FILTER LIST = $markersFilterList");
                                              print(
                                                  "MARKERSLIST = $markersList");
                                              print(
                                                  "markersTo show = $markersToShow");*/
                                              filterSelected = true;
                                            });
                                          },
                                        )
                                      : Container())
                          : FloatPosition(
                              isFilter: false,
                              isPlaneOff: true,
                              isPlane: false,
                              functionWhenClicked: () async {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Buscant la teva posició i redirigint el mapa ... ')),
                                );
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
                                widget.locationData =
                                    await userLocation.getLocation();

                                setState(() {
                                  mapController.move(
                                      LatLng(widget.locationData.latitude!,
                                          widget.locationData.longitude!),
                                      14.5);
                                });
                              },
                            )),
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
                                  : showingFilter
                                      ? Container()
                                      : Container())
                          : FloatPosition(
                              isFilter: false,
                              isPlaneOff: planeClicked,
                              isPlane: true,
                              functionWhenClicked: () async {
                                FlightService flights = FlightService();
                                print(planeClicked);
                                List<AllState> flightsToShow = [];
                                if (!planeClicked) {
                                  //We need to refresh the data of the flight when we clicked to see them
                                  flightsToShow =
                                      await flights.getFlightWithinBounds(
                                          mapController.center.latitude - 1,
                                          mapController.center.latitude + 1,
                                          mapController.center.longitude - 1,
                                          mapController.center.longitude + 1);
                                } else {
                                  flightsToShow = [];
                                }
                                //print(flightsToShow[0].icao24);
                                setState(() {
                                  planeClicked = !planeClicked;

                                  if (!planeClicked) {
                                    flightShown = AllState(
                                      icao24: "000",
                                      callSign: "NONE",
                                      origin: "CATALONIA",
                                      timePosition: 0,
                                      long: 0,
                                      lat: 0,
                                      baroAltitude: -1,
                                      trueTrack: 0,
                                      onGround: true,
                                      geoAltitude: -1,
                                      verticalVel: 0,
                                      horizontalVel: 0,
                                    );
                                  }

                                  flightsShowing = flightsToShow;
                                });
                              },
                            )),
                ),
                filterSelected
                    ? Align(
                        alignment: showingInfo
                            ? Alignment.topCenter
                            : Alignment.topRight,
                        child: Padding(
                            padding: showingInfo
                                ? const EdgeInsets.only(top: 10)
                                : const EdgeInsets.only(top: 10, right: 10),
                            child: showingInfo
                                ? (addingStation
                                    ? Container()
                                    : showingLegend
                                        ? Container()
                                        : showingFilter
                                            ? Container()
                                            : Container())
                                : FloatPosition(
                                    isFilter: true,
                                    isPlaneOff: planeClicked,
                                    isPlane: true,
                                    functionWhenClicked: () async {
                                      setState(() {
                                        filterSelected = false;
                                      });
                                    },
                                  )),
                      )
                    : Container(),
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
                    : (isAPlane && planeClicked)
                        ? (flightShown.callSign == "NONE")
                            ? Container()
                            : FloatPlaneInfo(flight: flightShown)
                        : !isAPlane
                            ? FloatInfo(
                                station: stationShown,
                                boxColor: Colors.blueGrey.shade200)
                            : Container()),
          ),
        ),
        /*SafeArea(
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
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
              child: SizedBox(
                  width: 130,
                  child: Image.asset("assets/pictures/marca_eetac_nova.png")),
            ),
          ),
        ),*/
      ]),
    );
  }
}
