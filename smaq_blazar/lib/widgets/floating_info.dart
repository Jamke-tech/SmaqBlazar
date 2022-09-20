import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class FloatInfo extends StatefulWidget {

  FloatInfo();

  @override
  State<FloatInfo> createState() => _FloatInfoState();
}

class _FloatInfoState extends State<FloatInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          border: Border.all(color: Colors.white,width: 4
          ),
          color: Colors.lightGreen.shade800,

        ),
        width: MediaQuery
            .of(context)
            .size
            .width * 0.9,
        height: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 2,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text(
                      "AQI",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    color: Colors.white)
                  ),

                  Text(
                      "23",
                      style: TextStyle(
                        fontSize: 75,
                      )
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
                          Container(
                            child: const Icon(
                              Icons.device_thermostat_outlined,
                              size: 30,
                              color: Colors.white,

                              )
                            ),
                          Container(
                            child: const Text(
                                "23.7ºC",
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
                                Icons.water_drop,
                                size: 30,
                                color: Colors.white,

                              )
                          ),
                          Container(
                            child: const Text(
                                "47.6% ",
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
                          Flexible(
                            flex: 2,
                            child: Container(
                                child: const Icon(
                                  Icons.tornado_rounded,
                                  size: 30,
                                  color: Colors.white,

                                )
                            ),
                          ),
                          Flexible(
                            flex:6,
                            child: Container(
                              child: const Text(
                                  "1013.4mb ",
                                  style: TextStyle(
                                    fontSize: 20,
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            )
          ],)

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

