import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class FloatInfo extends StatelessWidget {

  FloatInfo();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Colors.deepPurple.shade600,

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
            ),
            Flexible(
              child:Container(
                child: Text(
                    "AQI"

                ),
              )
            )
          ],)

    );
  }
}
