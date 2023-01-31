import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:weather_icons/weather_icons.dart';

import '../../classes/Model/station_model.dart';
import '../../classes/helpers/Time.dart';
import '../../classes/helpers/design_helper.dart';

class RadialGaugeAQI extends StatefulWidget {
  StationModel station;

  RadialGaugeAQI(
      {super.key,
        required this.station,
       });

  @override
  State<RadialGaugeAQI> createState() => _RadialGaugeAQIState();
}

class _RadialGaugeAQIState extends State<RadialGaugeAQI> {
  TimeAnalizer time = TimeAnalizer();
  DesignHelper design = DesignHelper();
  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      title:  GaugeTitle(
          alignment: GaugeAlignment.near,
         text: "Nivell de contaminació actual:",
          textStyle: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            shadows: [
              Shadow(
                  color: Colors.blueGrey,
                  offset: Offset.fromDirection(1.25),
                  blurRadius: 2.5)
            ],)),
      axes: <RadialAxis>[
        RadialAxis(
            startAngle: 140,
            endAngle: 40,
            isInversed: false,
            canScaleToFit: true,
            minimum: 0,
            maximum: 500,
            labelsPosition: ElementsPosition.outside,
            showTicks: false,
            showLastLabel: true,
            ticksPosition: ElementsPosition.outside,
            radiusFactor: 1,
            useRangeColorForAxis: true,
            canRotateLabels: true,
            ranges: [
              GaugeRange(
                startValue: 0,
                endValue: 50,
                color: Colors.lightGreen.shade800,
                startWidth: 16,
                endWidth: 16,
              ),
              GaugeRange(
                startValue: 51,
                endValue: 100,
                color: Colors.amber,
                startWidth: 16,
                endWidth: 16,
              ),
              GaugeRange(
                startValue: 101,
                endValue: 150,
                color: Colors.orange.shade800,
                startWidth: 16,
                endWidth: 16,
              ),
              GaugeRange(
                startValue: 151,
                endValue: 200,
                color: Colors.redAccent.shade700,
                startWidth: 16,
                endWidth: 16,
              ),
              GaugeRange(
                startValue: 201,
                endValue: 300,
                color: Colors.pink.shade800,
                startWidth: 16,
                endWidth: 16,
              ),
              GaugeRange(
                startValue: 301,
                endValue: 500,
                color: const Color(0xFF7D0023),
                startWidth: 16,
                endWidth: 16,
              ),
            ],
            pointers: [
              NeedlePointer(
                value: widget.station.getAQI().toDouble(),
                enableAnimation: true,
                needleLength: 0.75,
                needleStartWidth: 1,
                needleEndWidth: 15,
                needleColor: design.colorAQI(widget.station.getAQI()),
                knobStyle: KnobStyle(
                  knobRadius: 0.08,
                  color: design.colorAQI(widget.station.getAQI()),
                  borderColor: Colors.black,
                  borderWidth: 0.01,
                ),
                tailStyle: const TailStyle(),
                animationType: AnimationType.ease,
                animationDuration: 3000,
              )
            ],
            axisLineStyle: AxisLineStyle(
              color: Colors.blueGrey.shade200,
              thickness: 30,
              cornerStyle: CornerStyle.bothFlat,
            ),
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  widget: Text('AQI: ${widget.station.getAQI()==-1 ? "---" :widget.station.getAQI()}',
                      style: TextStyle(
                          shadows: [
                            Shadow(
                                color: Colors.blueGrey,
                                offset: Offset.fromDirection(1.25),
                                blurRadius: 2.5)
                          ],
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: design.colorAQI(widget.station.getAQI()))),
                  angle: 90,
                  positionFactor: 0.5)
            ])
      ],
    );
  }
}