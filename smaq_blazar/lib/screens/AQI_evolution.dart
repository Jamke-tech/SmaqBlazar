import 'package:SMAQ/classes/Model/evolution_model.dart';
import 'package:SMAQ/classes/Model/station_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:weather_icons/weather_icons.dart';

import '../classes/Time.dart';
import '../widgets/Icon_map.dart';

class EvolutionStation extends StatefulWidget {
  const EvolutionStation({super.key});

  @override
  State<EvolutionStation> createState() => _EvolutionStationState();
}

class _EvolutionStationState extends State<EvolutionStation> {
  late StationModel station;
  List<Marker> markersToDisplay = [];
  double pointerValue = 0;
  bool changeValueShow = true;
  EvolutionData dataShown =
      EvolutionData(AQILevels: [], pollutantsAverage: [], generalAQI: -1);

  @override
  Widget build(BuildContext context) {
    //We have to recover the info from the station
    TimeAnalizer time = TimeAnalizer();

    Object? data = ModalRoute.of(context)?.settings.arguments;
    station = data as StationModel;

    if (changeValueShow) {
      //We have to generate a new Evolution Object to show
      dataShown = EvolutionData(
          AQILevels: station.getAQIListFromCx(station.getAverageCxFromData(DateTime.parse(
              station.lastData[0].CreationDate.replaceAll("/", "-"))
              .subtract(Duration(hours: pointerValue.toInt())))),
          pollutantsAverage: station.getAverageCxFromData(DateTime.parse(
                  station.lastData[0].CreationDate.replaceAll("/", "-"))
              .subtract(Duration(hours: pointerValue.toInt()))),
          generalAQI: station.getAQI());

      print(dataShown.pollutantsAverage);

      //We change the Marker displayed
      markersToDisplay.clear();
      markersToDisplay.add(Marker(
          point: LatLng(station.lat, station.long),
          width: 20,
          height: 20,
          rotate: true,
          builder: (context) {
            //We have to set the color of the box
            Color colorSelected = station.colorAQI(dataShown.generalAQI);

            return IconMap(
              Iconcolor: colorSelected,
              size: 20,
              setStateforMap: () {
                //In this case we do not need any function is only to show the color
              },
            );
          }));
    }

    changeValueShow = false;
    return Scaffold(
      appBar: AppBar(
        title: const FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            "Evolució contaminació",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff00877F)
            ),
          ),
        ),
        backgroundColor: Colors.blueGrey.shade200,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 300,
            child: FlutterMap(
                options: MapOptions(
                  allowPanningOnScrollingParent: false,
                  center: LatLng(station.lat, station.long),
                  //LatLng(41.35581, 2.14141),
                  minZoom: 17,
                  zoom: 17,
                  maxZoom: 17,
                  plugins: [
                    MarkerClusterPlugin(),
                  ],
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                    retinaMode: true,
                  ),
                  MarkerLayerOptions(
                    markers: markersToDisplay,
                  )
                ]),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Nivell de contaminants promig i AQI: ",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  //border: Border.all(color: Colors.black, width: 1),
                  color: Colors.blueGrey.shade200, //Colors.lightGreen.shade800,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 5,
                      //offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Concentration
                      Expanded(
                        flex:2,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: dataShown.AQILevels.isNotEmpty
                                        ? station.colorAQI(dataShown.AQILevels[3])
                                        : Colors.blueGrey,
                                    border: Border.all(width: 1, color: Colors.black),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("CO: ",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: dataShown.AQILevels.isNotEmpty
                                                  ? station.colorAQI(
                                                      dataShown.AQILevels[3])
                                                  : Colors.blueGrey,
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4),
                                          child: Text(
                                              dataShown.pollutantsAverage.isNotEmpty
                                                  ? "${dataShown.pollutantsAverage[3].toStringAsFixed(3)} ppm"
                                                  : "NO DATA",
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: dataShown.AQILevels.isNotEmpty
                                          ? station.colorAQI(dataShown.AQILevels[5])
                                          : Colors.blueGrey,
                                      border:
                                          Border.all(width: 1, color: Colors.black),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("NO2: ",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: dataShown.AQILevels.isNotEmpty
                                                    ? station.colorAQI(
                                                        dataShown.AQILevels[5])
                                                    : Colors.blueGrey,
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4),
                                            child: Text(
                                                dataShown.pollutantsAverage.isNotEmpty
                                                    ? "${((dataShown.pollutantsAverage[5])*1000).toStringAsFixed(3)} ppb"
                                                    : "NO DATA",
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: dataShown.AQILevels.isNotEmpty
                                        ? station.colorAQI(dataShown.AQILevels[0])
                                        : Colors.blueGrey,
                                    border: Border.all(width: 1, color: Colors.black),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("O3: ",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: dataShown.AQILevels.isNotEmpty
                                                  ? station.colorAQI(
                                                      dataShown.AQILevels[0])
                                                  : Colors.blueGrey,
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4),
                                          child: Text(
                                              dataShown.pollutantsAverage.isNotEmpty
                                                  ? "${dataShown.pollutantsAverage[0].toStringAsFixed(3)} ppm"
                                                  : "NO DATA",
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: dataShown.AQILevels.isNotEmpty
                                          ? station.colorAQI(dataShown.AQILevels[4])
                                          : Colors.blueGrey,
                                      border:
                                          Border.all(width: 1, color: Colors.black),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("SO2: ",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: dataShown.AQILevels.isNotEmpty
                                                    ? station.colorAQI(
                                                        dataShown.AQILevels[4])
                                                    : Colors.blueGrey,
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4),
                                            child: Text(
                                                dataShown.pollutantsAverage.isNotEmpty
                                                    ? "${((dataShown.pollutantsAverage[4])*1000).toStringAsFixed(3)} ppb"
                                                    : "NO DATA",
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: dataShown.AQILevels.isNotEmpty
                                        ? station.colorAQI(dataShown.AQILevels[1])
                                        : Colors.blueGrey,
                                    border: Border.all(width: 1, color: Colors.black),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("PM 2.5: ",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: dataShown.AQILevels.isNotEmpty
                                                  ? station.colorAQI(
                                                      dataShown.AQILevels[1])
                                                  : Colors.blueGrey,
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4),
                                          child: Text(
                                              dataShown.pollutantsAverage.isNotEmpty
                                                  ? "${dataShown.pollutantsAverage[1].toStringAsFixed(2)} ug/m3"
                                                  : "NO DATA",
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: dataShown.AQILevels.isNotEmpty
                                          ? station.colorAQI(dataShown.AQILevels[2])
                                          : Colors.blueGrey,
                                      border:
                                          Border.all(width: 1, color: Colors.black),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("PM 10: ",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: dataShown.AQILevels.isNotEmpty
                                                    ? station.colorAQI(
                                                        dataShown.AQILevels[2])
                                                    : Colors.blueGrey,
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4),
                                            child: Text(
                                                dataShown.pollutantsAverage.isNotEmpty
                                                    ? "${dataShown.pollutantsAverage[2].toStringAsFixed(2)} ug/m3"
                                                    : "NO DATA",
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Aqi Level
                      Expanded(
                        flex:1,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("AQI: ",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: dataShown.AQILevels.isNotEmpty
                                                  ? station.colorAQI(
                                                  dataShown.AQILevels[3])
                                                  : Colors.blueGrey,
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4),
                                          child: Text(
                                              dataShown.pollutantsAverage.isNotEmpty
                                                  ? dataShown.AQILevels[3].toString()
                                                  : "NO DATA",
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("AQI: ",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: dataShown.AQILevels.isNotEmpty
                                                    ? station.colorAQI(
                                                    dataShown.AQILevels[5])
                                                    : Colors.blueGrey,
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4),
                                            child: Text(
                                                dataShown.pollutantsAverage.isNotEmpty
                                                    ? dataShown.AQILevels[5].toString()
                                                    : "NO DATA",
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("AQI: ",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: dataShown.AQILevels.isNotEmpty
                                                  ? station.colorAQI(
                                                  dataShown.AQILevels[0])
                                                  : Colors.blueGrey,
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4),
                                          child: Text(
                                              dataShown.pollutantsAverage.isNotEmpty
                                                  ? dataShown.AQILevels[0].toString()
                                                  : "NO DATA",
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("AQI: ",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: dataShown.AQILevels.isNotEmpty
                                                    ? station.colorAQI(
                                                    dataShown.AQILevels[4])
                                                    : Colors.blueGrey,
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4),
                                            child: Text(
                                                dataShown.pollutantsAverage.isNotEmpty
                                                    ? dataShown.AQILevels[4].toString()
                                                    : "NO DATA",
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [

                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("AQI: ",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: dataShown.AQILevels.isNotEmpty
                                                  ? station.colorAQI(
                                                  dataShown.AQILevels[1])
                                                  : Colors.blueGrey,
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4),
                                          child: Text(
                                              dataShown.pollutantsAverage.isNotEmpty
                                                  ? dataShown.AQILevels[1].toString()
                                                  : "NO DATA",
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                children: [

                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("AQI: ",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: dataShown.AQILevels.isNotEmpty
                                                    ? station.colorAQI(
                                                    dataShown.AQILevels[2])
                                                    : Colors.blueGrey,
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4),
                                            child: Text(
                                                dataShown.pollutantsAverage.isNotEmpty
                                                    ? dataShown.AQILevels[2].toString()
                                                    : "NO DATA",
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          const Divider(
            color: Colors.blueGrey,
            height: 4,
            thickness: 1.2,
            indent: 8,
            endIndent: 8,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Selecciona el temps de visualització: ",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: SfLinearGauge(
              minimum: 0,
              maximum: 10,
              isAxisInversed:true,
              axisTrackExtent: 10,
              animateAxis: true,
              showTicks: true,
              majorTickStyle: const LinearTickStyle(
                color: Colors.black,
                length: 8,
              ),
              minorTicksPerInterval: 0,
              interval: 1,
              axisTrackStyle: LinearAxisTrackStyle(
                  thickness: 16,
                  color: Colors.blueGrey.shade200,
                  edgeStyle: LinearEdgeStyle.bothCurve,
                  gradient: const LinearGradient(
                      //colors: [Colors.blueGrey.shade200, Colors.blueGrey],
                    colors:[ Color(0xff8CE0B0),
                      Color(0xff00BCD4),
                      Color(0xff00877F)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      //stops: [0.1, 0.5],
                      tileMode: TileMode.clamp)),
              labelFormatterCallback: (label) {
                if (label == "0") {
                  return "Últim";
                } else {
                  return "-${label}h";
                }
              },
              markerPointers: [
                LinearWidgetPointer(
                    value: pointerValue,
                    offset: -8,
                    markerAlignment: LinearMarkerAlignment.center,
                    dragBehavior: LinearMarkerDragBehavior.constrained,
                    onChanged: (newValue) {
                      setState(() {
                        pointerValue = newValue;
                      });
                    },
                    onChangeEnd: (newValue) {
                      setState(() {
                        pointerValue = (newValue.round()).toDouble();
                        changeValueShow = true;
                      });
                    },
                    position: LinearElementPosition.outside,
                    child: const Icon(
                      Icons.arrow_downward_rounded,
                      size: 30,
                      color: Colors.black,
                    ))
              ],
            ),
          ),
          const Divider(
            color: Colors.blueGrey,
            height: 6,
            thickness: 1,
            indent: 8,
            endIndent: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                  station.lastData.isNotEmpty
                      ? time.getActualizationTime(station.lastData[0].CreationDate)
                      : "NO Data for this station",
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey)),
            ),
          ),
        ],
      ),
    );
  }
}
