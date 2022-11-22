import 'package:SMAQ/classes/Time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:weather_icons/weather_icons.dart';

import '../classes/Model/all_state.dart';
import '../classes/Model/station_model.dart';
import '../screens/detail_station.dart';

class FloatPlaneInfo extends StatefulWidget {
  AllState flight;

  FloatPlaneInfo(
      {super.key,
        required this.flight,
        });

  @override
  State<FloatPlaneInfo> createState() => _FloatPlaneInfoState();
}

class _FloatPlaneInfoState extends State<FloatPlaneInfo> {
  @override
  Widget build(BuildContext context) {
    TimeAnalizer time = TimeAnalizer();

    return GestureDetector(
        onTap: () {
          //We have to show the full info for this plane
          //TODO

        },
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
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
            height: MediaQuery.of(context).size.height * 0.17,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Text(widget.flight.callSign,
                                      style: TextStyle(
                                        shadows: [
                                          Shadow(color: Colors.blueGrey,offset: Offset.fromDirection(1.25),blurRadius: 2.5 )
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
                                    child: FittedBox(
                                      fit: BoxFit.fitHeight,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.flag_circle_rounded,
                                            size: 25,
                                            color: Color(0xff00877F),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 8),
                                            child: Text(
                                                widget.flight.origin,
                                                style: const TextStyle(
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ],
                                      ),
                                    )),
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
                  flex: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
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
                              padding: const EdgeInsets.all(4.0),
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[
                                    const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Text(
                                          "Altitud de Vol:",
                                          style: TextStyle(
                                            fontSize: 15,
                                          )),
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(top: 2, left: 10),
                                          child: Icon(
                                            WeatherIcons.barometer,
                                            size: 16,
                                            color: Color(0xff00877F),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 2.0),
                                          child: Text(
                                              " ${widget.flight.baroAltitude} m" ,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(top: 2, left: 10),
                                          child: Icon(
                                            Icons.landscape_outlined,
                                            size: 16,
                                            color: Color(0xff00877F),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 2.0),
                                          child: Text(
                                              " ${widget.flight.geoAltitude} m" ,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ],
                                    ),


                                  ],
                                ),
                              )
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
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
                                padding: const EdgeInsets.all(4.0),
                                child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:[
                                      const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Text(
                                            "Velocitats de Vol:",
                                            style: TextStyle(
                                              fontSize: 15,
                                            )),
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 2, left: 10),
                                            child: Icon(
                                              widget.flight.verticalVel<0 ? Icons.vertical_align_bottom_outlined : Icons.vertical_align_top_outlined ,
                                              size: 16,
                                              color: Color(0xff00877F),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 2.0),
                                            child: Text(
                                                " ${widget.flight.verticalVel} m/s" ,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                )),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(top: 2, left: 10),
                                            child: Icon(
                                              Icons.speed_outlined,
                                              size: 16,
                                              color: Color(0xff00877F),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 2.0),
                                            child: Text(
                                                " ${widget.flight.horizontalVel} m/s" ,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                )),
                                          ),
                                        ],
                                      ),


                                    ],
                                  ),
                                )
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ]),
            )));
  }
}
