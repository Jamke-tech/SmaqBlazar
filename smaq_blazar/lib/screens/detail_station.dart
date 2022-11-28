import 'package:SMAQ/classes/Model/station_model.dart';
import 'package:SMAQ/classes/helpers/design_helper.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:weather_icons/weather_icons.dart';

import '../classes/helpers/Time.dart';
import '../widgets/gauge/radial_Gauge.dart';

class DetailStation extends StatefulWidget {
  const DetailStation({super.key});

  @override
  State<DetailStation> createState() => _DetailStationState();
}

class _DetailStationState extends State<DetailStation> {
  late StationModel station;

  @override
  Widget build(BuildContext context) {
    //We have to recover the info from the station
    TimeAnalizer time = TimeAnalizer();
    DesignHelper design = DesignHelper();

    Object? data = ModalRoute.of(context)?.settings.arguments;
    station = data as StationModel;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.map_rounded,
            color: Colors.blueGrey.shade700,
            size: 35,
            shadows: [
              Shadow(
                  color: Colors.blueGrey,
                  offset: Offset.fromDirection(1.25),
                  blurRadius: 2.5)
            ],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(station.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              shadows: [
                Shadow(
                    color: Colors.blueGrey,
                    offset: Offset.fromDirection(1.25),
                    blurRadius: 2.5)
              ],
              fontSize: 30,
              color: const Color(0xff00877F),
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.blueGrey.shade200,
      ),
      backgroundColor: Colors.blueGrey.shade50,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
            child: Text("Dades Meteorològiques: ",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  shadows: [
                    Shadow(
                        color: Colors.blueGrey,
                        offset: Offset.fromDirection(1.25),
                        blurRadius: 2.5)
                  ],
                )),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    //border: Border.all(color: Colors.black, width: 1),
                    color: Colors.blueGrey.shade200,
                    //Colors.lightGreen.shade800,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 5,
                        //offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 4, 8),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  //border: Border.all(color: Colors.black, width: 1),
                                  color: Colors.blueGrey.shade100,
                                  //Colors.lightGreen.shade800,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blueGrey.withOpacity(0.4),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      //offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                height: 80,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 4),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              4, 0, 4, 4),
                                          child: Text(
                                              station.lastData.isNotEmpty
                                                  ? "${station.lastData[0].Temperature.toStringAsFixed(2)} ºC"
                                                  : "---",
                                              style: const TextStyle(
                                                  fontSize: 25,
                                                  color: Color(0xff00877F),
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.file_download_rounded,
                                                  size: 10,
                                                  color: Color(0xff00877F),
                                                ),
                                                Text(
                                                    station.lastData.isNotEmpty
                                                        ? "${station.computeMaxAndMinFromData("Temp")[0].toStringAsFixed(2)} ºC"
                                                        : "---",
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black)),
                                                const Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 4),
                                                  child: Icon(
                                                    Icons.upload,
                                                    size: 10,
                                                    color: Color(0xff00877F),
                                                  ),
                                                ),
                                                Text(
                                                    station.lastData.isNotEmpty
                                                        ? "${station.computeMaxAndMinFromData("Temp")[1].toStringAsFixed(2)} ºC"
                                                        : "---",
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black)),
                                              ]),
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  //border: Border.all(color: Colors.black, width: 1),
                                  color: Colors.blueGrey.shade100,
                                  //Colors.lightGreen.shade800,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blueGrey.withOpacity(0.4),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      //offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                height: 80,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              4, 0, 4, 4),
                                          child: Text(
                                              station.lastData.isNotEmpty
                                                  ? "${station.lastData[0].Humidity.toStringAsFixed(2)} %"
                                                  : "---",
                                              style: const TextStyle(
                                                  fontSize: 26,
                                                  color: Color(0xff00877F),
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.file_download_rounded,
                                                    size: 10,
                                                    color: Color(0xff00877F),
                                                  ),
                                                  Text(
                                                      station.lastData
                                                              .isNotEmpty
                                                          ? "${station.computeMaxAndMinFromData("Humidity")[0].toStringAsFixed(2)} %"
                                                          : "---",
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black)),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4),
                                                    child: Icon(
                                                      Icons.upload,
                                                      size: 10,
                                                      color: Color(0xff00877F),
                                                    ),
                                                  ),
                                                  Text(
                                                      station.lastData
                                                              .isNotEmpty
                                                          ? "${station.computeMaxAndMinFromData("Humidity")[1].toStringAsFixed(2)} %"
                                                          : "---",
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black)),
                                                ]),
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            //border: Border.all(color: Colors.black, width: 1),
                            color: Colors.blueGrey.shade100,
                            //Colors.lightGreen.shade800,
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
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(8, 0, 0, 4),
                                  child: Icon(
                                    WeatherIcons.thermometer,
                                    size: 15,
                                    color: Color(0xff00877F),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 16, 4, 0),
                                  child: Text("dew",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xff00877F))),
                                ),
                                Text(
                                    station.lastData.isNotEmpty
                                        ? "${station.computeDewPoint(station.lastData[0].Temperature, station.lastData[0].Humidity).toStringAsFixed(2)} ºC"
                                        : "---",
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(8, 2, 2, 0),
                                  child: Icon(
                                    Icons.tornado_rounded,
                                    size: 18,
                                    //color: Colors.black,
                                    color: Color(0xff00877F),
                                  ),
                                ),
                                Text(
                                    station.lastData.isNotEmpty
                                        ? "${station.lastData[0].Pressure.toStringAsFixed(2)} hPa"
                                        : "---",
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(8, 0, 2, 8),
                                  child: Icon(
                                    WeatherIcons.rain,
                                    size: 18,
                                    color: Color(0xff00877F),
                                  ),
                                ),
                                Text(
                                    station.lastData.isNotEmpty
                                        ? "${station.lastData[0].Rain.toStringAsFixed(2)} mm"
                                        : "---",
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ))),
          const Divider(
            color: Color(0xff00877F),
            height: 6,
            thickness: 1,
            indent: 8,
            endIndent: 8,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
            child: RadialGaugeAQI(station: station),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    //border: Border.all(color: Colors.black, width: 1),
                    color: Colors.blueGrey.shade100,
                    //Colors.lightGreen.shade800,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.25),
                        spreadRadius: 1.1,
                        blurRadius: 4,
                        //offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: Text(
                              "Estat del aire: ${ station.getAQI()==-1 ? "---" : design.getLevel(station.getAQI())}",
                              style: TextStyle(
                                  shadows: [
                                    Shadow(
                                        color: Colors.blueGrey,
                                        offset: Offset.fromDirection(1.25),
                                        blurRadius: 2.5)
                                  ],
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: design.colorAQI(station.getAQI()))),
                        ),
                        const Divider(
                          color: Colors.white,
                          height: 4,
                          thickness: 1.2,
                          indent: 8,
                          endIndent: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
                          child: Text(station.getAQI()==-1 ? "---" :design.textAQIExtended(station.getAQI()),
                              style: const TextStyle(
                                  fontSize: 15,
                                  //fontWeight: FontWeight.bold,
                                  color: Color(0xff00877F))),
                        ),
                        const Divider(
                          color: Colors.white,
                          height: 4,
                          thickness: 1.2,
                          indent: 8,
                          endIndent: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child:  Text(
                              "Contaminant predominant:  ${  station.lastData.isNotEmpty ? design.getMainPollutant(station.getAQI(),station.getAQIListFromCx(station.getAverageCxFromData(DateTime.parse(station.lastData[0].CreationDate.replaceAll("/", "-"))))) : "---"}",
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Divider(
            color: Color(0xff00877F),
            height: 4,
            thickness: 1.2,
            indent: 8,
            endIndent: 8,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
            child: Text("Concentració de contaminants: ",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, shadows: [
                  Shadow(
                      color: Colors.blueGrey,
                      offset: Offset.fromDirection(1.25),
                      blurRadius: 2.5)
                ],)),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 32),
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
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: station.lastAQI.isNotEmpty
                                  ? design.colorAQI(station.lastAQI[3])
                                  : const Color(0xff00877F),
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
                                        color: station.lastAQI.isNotEmpty
                                            ? design.colorAQI(station.lastAQI[3])
                                            : Colors.blueGrey,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                        station.lastData.isNotEmpty
                                            ? "${station.lastData[0].CxCO.toStringAsFixed(1)} ppm"
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
                                color: station.lastAQI.isNotEmpty
                                    ? design.colorAQI(station.lastAQI[5])
                                    : const Color(0xff00877F),
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
                                          color: station.lastAQI.isNotEmpty
                                              ? design.colorAQI(station.lastAQI[5])
                                              : Colors.blueGrey,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                          station.lastData.isNotEmpty
                                              ? "${((station.lastData[0].CxNO2) * 1000).toStringAsFixed(0)} ppb"
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
                              color: station.lastAQI.isNotEmpty
                                  ? design.colorAQI(station.lastAQI[0])
                                  : const Color(0xff00877F),
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
                                        color: station.lastAQI.isNotEmpty
                                            ? design.colorAQI(station.lastAQI[0])
                                            : Colors.blueGrey,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                        station.lastData.isNotEmpty
                                            ? "${station.lastData[0].CxO3.toStringAsFixed(3)} ppm"
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
                                color: station.lastAQI.isNotEmpty
                                    ? design.colorAQI(station.lastAQI[4])
                                    : const Color(0xff00877F),
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
                                          color: station.lastAQI.isNotEmpty
                                              ? design.colorAQI(station.lastAQI[4])
                                              : Colors.blueGrey,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                          station.lastData.isNotEmpty
                                              ? "${((station.lastData[0].CxSO2) * 1000).toStringAsFixed(0)} ppb"
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
                      )
                    ],
                  ),
                ),
              )),
          const Divider(
            color: Color(0xff00877F),
            height: 4,
            thickness: 1.2,
            indent: 8,
            endIndent: 8,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
            child: Text("Particules en Suspensió: ",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, shadows: [
                  Shadow(
                      color: Colors.blueGrey,
                      offset: Offset.fromDirection(1.25),
                      blurRadius: 2.5)
                ],)),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 32),
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
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: station.lastAQI.isNotEmpty
                                  ? design.colorAQI(station.lastAQI[1])
                                  : const Color(0xff00877F),
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
                                        color: station.lastAQI.isNotEmpty
                                            ? design.colorAQI(station.lastAQI[1])
                                            : Colors.blueGrey,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                        station.lastData.isNotEmpty
                                            ? "${station.lastData[0].PM25.toStringAsFixed(1)} ug/m3"
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
                        padding: const EdgeInsets.only(top: 8, bottom: 0),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: station.lastAQI.isNotEmpty
                                    ? design.colorAQI(station.lastAQI[2])
                                    : const Color(0xff00877F),
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
                                          color: station.lastAQI.isNotEmpty
                                              ? design.colorAQI(station.lastAQI[2])
                                              : Colors.blueGrey,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                          station.lastData.isNotEmpty
                                              ? "${station.lastData[0].PM10} ug/m3"
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
              )),
          const Divider(
            color: Color(0xff00877F),
            height: 4,
            thickness: 1.2,
            indent: 8,
            endIndent: 8,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
            child: Text("Valors lumínics: ",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, shadows: [
                  Shadow(
                      color: Colors.blueGrey,
                      offset: Offset.fromDirection(1.25),
                      blurRadius: 2.5)
                ],)),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 32),
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
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            WeatherIcons.day_sunny,
                            size: 20,
                            color: Color(0xff00877F),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, top: 4),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: station.lastData.isNotEmpty
                                      ? ([
                                          const Text("UV",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                              )),
                                          Text(
                                              " ${station.lastData[0].UVSource}: ",
                                              style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                              )),
                                          Text(
                                              "${station.lastData[0].UV} (${design.colorUV(station.lastData[0].UV)[1]})",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: design.colorUV(station
                                                      .lastData[0].UV)[0]))
                                        ])
                                      : ([
                                          const Text("UV X:",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                              )),
                                          const Text(" NO DATA",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.blueGrey,
                                              ))
                                        ])),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.graphic_eq_outlined,
                              size: 20,
                              color: Color(0xff00877F),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8, top: 4),
                                child: Row(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text("Intensitat lumínica: (Lux)",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 32, top: 2, bottom: 8),
                        child: station.lastData.isNotEmpty
                            ? FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Row(
                                  children: [
                                    Text(
                                        station.lastData.isNotEmpty
                                            ? "("
                                            : "NO DATA",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        )),
                                    Text(
                                        station.lastData.isNotEmpty
                                            ? "R: ${station.lastData[0].RedLux}"
                                            : "NO DATA",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.red,
                                        )),
                                    Text(
                                        station.lastData.isNotEmpty
                                            ? ","
                                            : "NO DATA",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        )),
                                    Text(
                                        station.lastData.isNotEmpty
                                            ? "G: ${station.lastData[0].GreenLux}"
                                            : "NO DATA",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.green,
                                        )),
                                    Text(
                                        station.lastData.isNotEmpty
                                            ? ","
                                            : "NO DATA",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        )),
                                    Text(
                                        station.lastData.isNotEmpty
                                            ? "B: ${station.lastData[0].BlueLux}"
                                            : "NO DATA",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.blue,
                                        )),
                                    Text(
                                        station.lastData.isNotEmpty
                                            ? ","
                                            : "NO DATA",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        )),
                                    Text(
                                        station.lastData.isNotEmpty
                                            ? "IR: ${station.lastData[0].IR}"
                                            : "NO DATA",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.redAccent.shade700,
                                        )),
                                    Text(
                                        station.lastData.isNotEmpty
                                            ? ")"
                                            : "NO DATA",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              )
                            : const Text("NO DATA",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                )),
                      )
                    ],
                  ),
                ),
              )),
          const Divider(
            color: Color(0xff00877F),
            height: 4,
            thickness: 1.2,
            indent: 8,
            endIndent: 8,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
            child: Text("Sonòmetre: ",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  shadows: [
                    Shadow(
                        color: Colors.blueGrey,
                        offset: Offset.fromDirection(1.25),
                        blurRadius: 2.5)
                  ],)),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 32),
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
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.music_note_outlined,
                            size: 20,
                            color: Color(0xff00877F),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, top: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text("Nivell Sonor: ",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      )),
                                  Text(
                                      station.lastData.isNotEmpty
                                          ? "${station.lastData[0].Sound} dBSPL"
                                          : "NO DATA",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          const Divider(
            color: Color(0xff00877F),
            height: 4,
            thickness: 1.2,
            indent: 8,
            endIndent: 8,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
            child: Text("Informació històrica: ",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, shadows: [
                  Shadow(
                      color: Colors.blueGrey,
                      offset: Offset.fromDirection(1.25),
                      blurRadius: 2.5)
                ],)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: ElevatedButton(
                        onPressed: () {
                          //Navigate to page graphics
                          if(station.lastData.isNotEmpty){
                          Navigator.pushNamed(context, '/graphs_station',
                              arguments: station);}else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'No hi han dades suficients per mostrar gràfiques.')),
                            );
                          }

                        },
                        child: const Text("Gràfiques",
                            style: TextStyle(fontSize: 18))),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: ElevatedButton(
                      onPressed: () {
                        //Navigate to page Evolution
                        if(station.lastData.isNotEmpty){Navigator.pushNamed(context, '/evolution_station',
                            arguments: station);}else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "No hi han dades suficients per mostrar l'evolució temporal")),
                          );
                        }
                      },
                      child: const Text(
                        "Evolució AQI",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                )
              ],
            )),
          ),
          const Divider(
            color: Color(0xff00877F),
            height: 4,
            thickness: 1.2,
            indent: 8,
            endIndent: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text("ID Estació: ${station.IDStation}",
                  style: const TextStyle(
                    fontSize: 15,
                    //fontWeight: FontWeight.bold,
                    color: Color(0xff00877F),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                  station.lastData.isNotEmpty
                      ? time.getActualizationTime(
                          station.lastData[0].CreationDate)
                      : "NO DATA",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff00877F),
                  )),
            ),
          ),
          const Divider(
            color: Color(0xff00877F),
            height: 8,
            thickness: 1.2,
            indent: 8,
            endIndent: 8,
          ),
        ],
      ),
    );
  }
}
