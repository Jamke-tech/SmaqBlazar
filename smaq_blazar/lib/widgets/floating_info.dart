import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smaq_blazar/classes/station.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class FloatInfo extends StatefulWidget {
  Station station;
  Color AqiColor;
  Color boxcolor;

  FloatInfo(
      {super.key,
      required this.station,
      required this.boxcolor,
      required this.AqiColor});

  @override
  State<FloatInfo> createState() => _FloatInfoState();
}

class _FloatInfoState extends State<FloatInfo> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          //We have to show the full info for this station

        },
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black, width: 1),
              color: widget.boxcolor, //Colors.lightGreen.shade800,
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
            height: MediaQuery.of(context).size.height * 0.14,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(widget.station.name,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          const Text("AQI",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child:
                            Text(widget.station.AqiLevel.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: widget.AqiColor,
                                )),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.device_thermostat_outlined,
                            size: 16,
                            color: Colors.white,
                          ),
                          Text("${widget.station.temp}ºC",
                              style: TextStyle(
                                fontSize: 16,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.water_drop,
                            size: 16,
                            color: Colors.white,
                          ),
                          Text("${widget.station.humidity}%",
                              style: const TextStyle(
                                fontSize: 16,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.tornado_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:4.0),
                            child: Text("${widget.station.pressure}mb",
                                style: const TextStyle(
                                  fontSize: 16,
                                )),
                          ),
                        ],
                      ),

                    ],
                  ),
                )

              ]),
            )));
  }
}
