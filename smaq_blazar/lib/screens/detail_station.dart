import 'package:SMAQ/classes/station_model.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:weather_icons/weather_icons.dart';

import '../classes/Time.dart';

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

    Object? data = ModalRoute
        .of(context)
        ?.settings
        .arguments;
    station = data as StationModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          station.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 30,
            color: Colors.black,

          ),
        ),
        backgroundColor: Colors.blueGrey.shade200,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: Text("Dades Meteorològiques: ",
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
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.device_thermostat_outlined,
                                size: 20,
                                color: Color(0xff00877F),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Text(
                                    station.lastData.isNotEmpty
                                        ? "${station.lastData[0].Temperature
                                        .toStringAsFixed(3)} ºC"
                                        : "ERROR",
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.white)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                WeatherIcons.humidity,
                                size: 20,
                                color: Color(0xff00877F),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6, left: 4),
                                child: Text(
                                    station.lastData.isNotEmpty
                                        ? "${station.lastData[0].Humidity
                                        .toStringAsFixed(3)} %"
                                        : "ERROR",
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.white)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.tornado_rounded,
                                size: 20,
                                //color: Colors.black,
                                color: Color(0xff00877F),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text(
                                    station.lastData.isNotEmpty
                                        ? "${station.lastData[0].Pressure
                                        .toStringAsFixed(3)} hPa"
                                        : "ERROR",
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.white)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                WeatherIcons.rain,
                                size: 20,
                                color: Color(0xff00877F),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5, top: 6),
                                child: Text(
                                    station.lastData.isNotEmpty
                                        ? "${station.lastData[0].Rain
                                        .toStringAsFixed(3)} mm"
                                        : "ERROR",
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.white)),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )),
          const Divider(
            color: Color(0xff00877F),
            height: 6,
            thickness: 1,
            indent: 8,
            endIndent: 8,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: SfRadialGauge(
              title: const GaugeTitle(
                  alignment: GaugeAlignment.near,
                  text: "Nivell de contaminació actual",
                  textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              axes: <RadialAxis>[
                RadialAxis(
                    startAngle: 140,
                    endAngle: 40,
                    isInversed: false,
                    canScaleToFit: true,

                    minimum: 0,
                    maximum: 400,
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
                        endWidth: 16,),
                      GaugeRange(
                        startValue: 51,
                        endValue: 100,
                        color: Colors.amber,
                        startWidth: 16,
                        endWidth: 16,),
                      GaugeRange(
                        startValue: 101,
                        endValue: 150,
                        color: Colors.orange.shade800,
                        startWidth: 16,
                        endWidth: 16,),
                      GaugeRange(
                        startValue: 151,
                        endValue: 200,
                        color: Colors.redAccent.shade700,
                        startWidth: 16,
                        endWidth: 16,),
                      GaugeRange(
                        startValue: 201,
                        endValue: 300,
                        color: Colors.pink.shade800,
                        startWidth: 16,
                        endWidth: 16,),
                      GaugeRange(
                        startValue: 301,
                        endValue: 400,
                        color: const Color(0xFF7D0023),
                        startWidth: 16,
                        endWidth: 16,
                      ),
                    ],
                    pointers: [
                      NeedlePointer(

                        value: station.getAQI().toDouble(),
                        enableAnimation: true,
                        needleLength: 0.75,
                        needleStartWidth: 1,
                        needleEndWidth: 15,
                        needleColor: station.colorAQI(station.getAQI()),
                        knobStyle: KnobStyle(
                          knobRadius: 0.08,
                          color: station.colorAQI(station.getAQI()),
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
                          widget: Text('AQI: ${station.getAQI()}',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: station.colorAQI(station.getAQI()))),
                          angle: 90,
                          positionFactor: 0.5
                      )
                    ])
              ],
            ),
          ),
          /*const Padding(
            padding: EdgeInsets.fromLTRB(8.0,0,8,8),
            child: Text("Advertències médiques: ",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),*/
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 16),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Text(
                        "Nivell de contaminació : ${station.getLevel(
                            station.getAQI())}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: station.colorAQI(station.getAQI()))),
                  ),
                  Text(station.textAQI(station.getAQI()),
                      style: const TextStyle(
                          fontSize: 15,
                          //fontWeight: FontWeight.bold,
                          color: Colors.blueGrey)),
                ],
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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Concentració de contaminants: ",
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
                                  ? station.colorAQI(station.lastAQI[3])
                                  : Color(0xff00877F),
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
                                            ? station
                                            .colorAQI(station.lastAQI[3])
                                            : Colors.blueGrey,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                        station.lastData.isNotEmpty
                                            ? "${station.lastData[0].CxCO
                                            .toStringAsFixed(3)} ppm"
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
                                    ? station.colorAQI(station.lastAQI[5])
                                    : Color(0xff00877F),
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
                                              ? station
                                              .colorAQI(station.lastAQI[5])
                                              : Colors.blueGrey,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                          station.lastData.isNotEmpty
                                              ? "${station.lastData[0].CxNO2
                                              .toStringAsFixed(3)} ppm"
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
                                  ? station.colorAQI(station.lastAQI[0])
                                  : Color(0xff00877F),
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
                                            ? station
                                            .colorAQI(station.lastAQI[0])
                                            : Colors.blueGrey,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                        station.lastData.isNotEmpty
                                            ? "${station.lastData[0].CxO3
                                            .toStringAsFixed(3)} ppm"
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
                                    ? station.colorAQI(station.lastAQI[4])
                                    : Color(0xff00877F),
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
                                              ? station
                                              .colorAQI(station.lastAQI[4])
                                              : Colors.blueGrey,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                          station.lastData.isNotEmpty
                                              ? "${station.lastData[0].CxSO2
                                              .toStringAsFixed(3)} ppm"
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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Particules en Suspensió: ",
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
                                  ? station.colorAQI(station.lastAQI[1])
                                  : Color(0xff00877F),
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
                                            ? station
                                            .colorAQI(station.lastAQI[1])
                                            : Colors.blueGrey,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                        station.lastData.isNotEmpty
                                            ? "${station.lastData[0]
                                            .PM25} ug/m3"
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
                                    ? station.colorAQI(station.lastAQI[2])
                                    : Color(0xff00877F),
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
                                              ? station
                                              .colorAQI(station.lastAQI[2])
                                              : Colors.blueGrey,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                          station.lastData.isNotEmpty
                                              ? "${station.lastData[0]
                                              .PM10} ug/m3"
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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Valors lumínics: ",
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
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(WeatherIcons.day_sunny,
                            size: 20, color: Color(0xff00877F),),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, top: 4),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:
                                  station.lastData.isNotEmpty
                                      ? ([ const Text("UV",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      )), Text(
                                      " ${station.lastData[0].UVSource}: ",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      )),
                                    Text(
                                        "${station.lastData[0].UV} (${station
                                            .colorUV(
                                            station.lastData[0].UV)[1]})",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: station.colorUV(
                                              station.lastData[0].UV)[0]

                                        ))
                                  ]) : ([
                                    const Text("UV X:",
                                      style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      )),
                                      const Text(
                                        " NO DATA",
                                      style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blueGrey,))])

                            ),
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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Sonòmetre: ",
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
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.music_note_outlined,
                              size: 20,  color: Color(0xff00877F),),
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
          const Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Text("Informació històrica: ",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: ElevatedButton(onPressed: () {
                          //Navigate to page graphics
                          Navigator.pushNamed(context, '/graphs_station',
                              arguments: station);
                        }, child: const Text("Gràfiques", style: TextStyle(
                            fontSize: 16))),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: ElevatedButton(onPressed: () {
                          //Navigate to page Evolution
                          Navigator.pushNamed(context, '/evolution_station',
                              arguments: station);
                        }, child: const Text("Evolució AQI", style: TextStyle(
                            fontSize: 16),),),
                      ),
                    )
                  ],
                )
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
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text("ID Estació: ${station.IDStation}",
                  style: const TextStyle(
                      fontSize: 15,
                      //fontWeight: FontWeight.bold,
                    color: Color(0xff00877F),)),
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
                      color: Color(0xff00877F),)),
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
