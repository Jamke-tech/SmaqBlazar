import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:weather_icons/weather_icons.dart';

class FloatFilter extends StatefulWidget {
  Function (int filter, String selectedMethod) functionWhenFilterChanged;
 FloatFilter({super.key, required this.functionWhenFilterChanged});

  @override
  State<FloatFilter> createState() => _FloatFilterState();
}

class _FloatFilterState extends State<FloatFilter> {
  String selectedMethod = "Únic";
  List<String> methods = ['Múltiple', 'Únic'];
  double pollutantsToShow = 0;
  bool pollutantsChanged = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.zero,
              topRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8)),
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
        //height: MediaQuery.of(context).size.height * 0.16,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
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
                    child: DropdownButton(
                      underline: Container(),
                      elevation: 8,
                      iconSize: 20,
                      alignment: AlignmentDirectional.center,
                      icon: const Icon(
                        Icons.arrow_drop_down_circle_outlined,
                        color: Colors.black,
                      ),
                      value: selectedMethod,
                      onChanged: (String? newValue) {
                        setState(() {
                          //Repaint graphic
                          selectedMethod = newValue!;
                        });
                      },
                      items: methods.map((String methods) {
                        return DropdownMenuItem<String>(
                          value: methods,
                          child: Text(methods,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              )),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Expanded(
                      child: SfLinearGauge(
                        axisLabelStyle: const TextStyle(
                          leadingDistribution: TextLeadingDistribution.even,
                          fontSize: 9,
                          color: Color(0xff00877F)
                        ),
                        labelOffset: 4,
                        labelPosition: LinearLabelPosition.inside,
                        minimum: 0,
                        maximum: 5,
                        axisTrackExtent: 15,
                        animateAxis: true,
                        showTicks: true,
                        maximumLabels: 5,
                        majorTickStyle: const LinearTickStyle(
                          color: Colors.black,
                          length: 2,
                        ),
                        minorTicksPerInterval: 0,
                        interval: 1,
                        axisTrackStyle: LinearAxisTrackStyle(
                            thickness: 32,
                            color: Colors.blueGrey.shade200,
                            edgeStyle: LinearEdgeStyle.bothCurve,
                            gradient: LinearGradient(
                                //colors: [Colors.blueGrey.shade200, Colors.blueGrey],

                                colors: [
                                  Colors.lightGreen.shade800,
                                  Colors.amber,
                                  Colors.orange.shade800,
                                  Colors.redAccent.shade700,
                                  Colors.pink.shade800,
                                  const Color(0xFF7D0023)
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                //stops: [0.1, 0.5],
                                tileMode: TileMode.clamp)),
                        labelFormatterCallback: (label) {
                          switch (int.parse(label)) {
                            case 0:
                              return "BO";
                            case 1:
                              return "MODERAT";
                            case 2:
                              return "POBRE";
                            case 3:
                              return "INSALUBRE";
                            case 4:
                              return "SEVER";
                            case 5:
                              return "PERILLÓS";
                            default:
                              return "";
                          }
                        },
                        markerPointers: [
                          LinearWidgetPointer(
                              value: pollutantsToShow.toDouble(),
                              offset: -8,
                              markerAlignment: LinearMarkerAlignment.center,
                              dragBehavior:
                                  LinearMarkerDragBehavior.constrained,
                              onChanged: (newValue) {
                                setState(() {
                                  pollutantsToShow = newValue;
                                });
                              },
                              onChangeEnd: (newValue) {
                                setState(() {
                                  pollutantsToShow =
                                      (newValue.round()).toDouble();
                                });
                                widget.functionWhenFilterChanged(newValue.round(),selectedMethod);
                              },
                              position: LinearElementPosition.cross,
                              child: const Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Icon(
                                  WeatherIcons.smoke,
                                  size: 28,
                                  color: Colors.black,
                                ),
                              ))
                        ],
                      ),
                    ),
            ],
          ),
        ));
  }
}
