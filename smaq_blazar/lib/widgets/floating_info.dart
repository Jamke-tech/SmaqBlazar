import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smaq_blazar/classes/station.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class FloatInfo extends StatefulWidget {
  Station station;
  Color boxcolor;

  FloatInfo({super.key, required this.station, required this.boxcolor});

  @override
  State<FloatInfo> createState() => _FloatInfoState();
}

class _FloatInfoState extends State<FloatInfo> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){


      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black,width: 2
            ),
            color: widget.boxcolor,//Colors.lightGreen.shade800,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.7),
                spreadRadius: 2,
                blurRadius: 9,
                //offset: Offset(0, 3), // changes position of shadow
              ),
            ],

          ),
          width: MediaQuery
              .of(context)
              .size
              .width * 0.95,
          height:MediaQuery
              .of(context)
              .size
              .height * 0.20,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                              widget.station.name,
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              )
                          ),
                        ),
                      ),
                      /*Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: IconButton(onPressed: (){},
                            icon: const Icon(
                              Icons.open_in_browser_outlined,
                              color: Colors.black,
                              size: 30,
                            )),
                      )*/
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 2,
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Align (
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  "AQI",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                color: Colors.white)
                              ),
                            ),

                            Flexible(
                              child: Text(
                                  widget.station.AqiLevel.toString(),
                                  style: const TextStyle(
                                    fontSize: 65,
                                  )
                              ),
                            ),
                          ],
                        )
                      ),
                      Expanded(
                        flex: 1,
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Row(

                                  children: [
                                    const Icon(
                                      Icons.device_thermostat_outlined,
                                      size: 20,
                                      color: Colors.white,

                                      ),
                                    Expanded(
                                      child: Text(
                                          "${widget.station.temp}ºC",
                                          style: TextStyle(
                                            fontSize: 20,
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(

                                  children: [
                                    const Icon(
                                      Icons.water_drop,
                                      size: 20,
                                      color: Colors.white,

                                    ),
                                    Expanded(
                                      child: Text(
                                          "${widget.station.humidity}%",
                                          style: TextStyle(
                                            fontSize: 20,
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(

                                  children: [
                                    Container(
                                        child: const Icon(
                                          Icons.tornado_rounded,
                                          size: 20,
                                          color: Colors.white,

                                        )
                                    ),
                                    Expanded(
                                      child: Text(
                                          "${widget.station.pressure}mb",
                                          style: const TextStyle(
                                            fontSize: 20,
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                      )
                    ],),
                ),
              ],
            ),
          )

      ),
    );
  }
}
/*Flexible(
              child: SfRadialGauge(
                axes: [
                  RadialAxis(showLabels: false, showAxisLine: false, showTicks: false,
                      minimum: 0, maximum: 99,
                      ranges: <GaugeRange>[
                        GaugeRange(startValue: 0, endValue: 33,
                            color: Color(0xFFFE2A25),
                            label: 'Good',
                            sizeUnit: GaugeSizeUnit.factor,
                            labelStyle: GaugeTextStyle(fontFamily: 'Times', fontSize:  20),
                            startWidth: 0.65, endWidth: 0.65
                        ),GaugeRange(startValue: 33, endValue: 66,
                          color:Color(0xFFFFBA00), label: 'Bad',
                          labelStyle: GaugeTextStyle(fontFamily: 'Times', fontSize:   20),
                          startWidth: 0.65, endWidth: 0.65, sizeUnit: GaugeSizeUnit.factor,
                        ),
                        GaugeRange(startValue: 66, endValue: 99,
                          color:Color(0xFF00AB47), label: 'Mortal',
                          labelStyle: GaugeTextStyle(fontFamily: 'Times', fontSize:   20),
                          sizeUnit: GaugeSizeUnit.factor,
                          startWidth: 0.65, endWidth: 0.65,
                        ),

                      ],
                      pointers: <GaugePointer>[
                        NeedlePointer(
                            value: 60, //TODO: here it goes de AQI level
                            lengthUnit: GaugeSizeUnit.factor,

                      )]
                  )


                ],
              ),
            ),*/

