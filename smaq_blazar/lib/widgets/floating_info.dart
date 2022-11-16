import 'package:SMAQ/classes/Time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:weather_icons/weather_icons.dart';

import '../classes/Model/station_model.dart';
import '../screens/detail_station.dart';

class FloatInfo extends StatefulWidget {
  StationModel station;
  Color aqiColor;
  Color boxColor;

  FloatInfo(
      {super.key,
      required this.station,
      required this.boxColor,
      required this.aqiColor});

  @override
  State<FloatInfo> createState() => _FloatInfoState();
}

class _FloatInfoState extends State<FloatInfo> {
  @override
  Widget build(BuildContext context) {
    TimeAnalizer time = TimeAnalizer();

    return GestureDetector(
        onTap: () {
          //We have to show the full info for this station
          Navigator.pushNamed(context, '/detail_station',
              arguments: widget.station);
        },
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              //border: Border.all(color: Colors.black, width: 1),
              color: widget.boxColor, //Colors.lightGreen.shade800,
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
            height: MediaQuery.of(context).size.height * 0.17,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Text(widget.station.name,
                                      style: TextStyle(
                                        shadows: [
                                          Shadow(color: const Color(0xff00877F),offset: Offset.fromDirection(1.25),blurRadius: 2.5 )
                                        ],
                                        fontSize: 15,
                                        color: const Color(0xff00877F),
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
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
                                          const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 2),
                                            child: Icon(
                                              WeatherIcons.smoke,
                                              size: 25,
                                              color: Color(0xff00877F),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: Text(
                                                widget.station.getAQI() != -1
                                                    ? widget.station
                                                        .getAQI()
                                                        .toString()
                                                    : "---",
                                                style: TextStyle(
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      widget.station.getAQI() !=
                                                              -1
                                                          ? widget.aqiColor
                                                          : Colors.white,
                                                )),
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            ),
                          ]),
                    )),
                const Divider(
                  color: Color(0xff00877F),
                  height: 8,
                  thickness: 1.5,
                  indent: 0,
                  endIndent: 0,
                ),
                Expanded(
                  flex: 3,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 2, left: 10),
                                  child: Icon(
                                    Icons.device_thermostat_outlined,
                                    size: 16,
                                    color: Color(0xff00877F),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Text(
                                      widget.station.lastData.isNotEmpty
                                          ? "${widget.station.lastData[0].Temperature.toStringAsFixed(2)}ºC"
                                          : "---",
                                      style: const TextStyle(
                                        fontSize: 16,
                                      )),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 6, left: 10),
                                  child: Icon(
                                    WeatherIcons.humidity,
                                    size: 16,
                                    color: Color(0xff00877F),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Text(
                                      widget.station.lastData.isNotEmpty
                                          ? "${widget.station.lastData[0].Humidity.toStringAsFixed(2)} %"
                                          : "---",
                                      style: const TextStyle(
                                        fontSize: 16,
                                      )),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10.0, right: 2),
                                    child: Icon(
                                      Icons.tornado_rounded,
                                      size: 16,
                                      color: Color(0xff00877F),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2.0),
                                    child: Text(
                                        widget.station.lastData.isNotEmpty
                                            ? "${widget.station.lastData[0].Pressure.toStringAsFixed(2)} hPa"
                                            : "---",
                                        style: const TextStyle(
                                          fontSize: 16,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                          widget.station.lastData.isNotEmpty
                              ? time.getDateTimeInLocal(
                                  widget.station.lastData[0].CreationDate)
                              : "NO DATA AVAILABLE FOR THIS STATION",
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          )),
                    ],
                  ),
                ),
              ]),
            )));
  }
}
