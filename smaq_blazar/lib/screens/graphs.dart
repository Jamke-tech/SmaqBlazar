import 'package:SMAQ/classes/graphs_generator.dart';
import 'package:SMAQ/classes/station_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:weather_icons/weather_icons.dart';

class GraphsStation extends StatefulWidget {
  const GraphsStation({super.key});

  @override
  State<GraphsStation> createState() => _GraphsStationState();
}

class _GraphsStationState extends State<GraphsStation> {
  late StationModel station;
  String lastTitle = "lope";
  String selectedTitleGraphs = "nope";
  String selectedSubTitleGraphs = "nope";
  List<String> subTitle = [];

  //Variables per la selecció de gràfics
  List<String> firstTitle = [
    'Meteorología',
    'Contaminants',
    'Partícules',
    'Llum',
    'So'
  ];
  List<String> pollutionsGraphs = ['CO', 'O3', 'NO2', 'SO2'];
  List<String> meteoGraphs = ['Temperatura', 'Humitat', 'Pressió', 'Pluja'];
  List<String> particlesGraphs = ['PM 2.5', 'PM 10'];
  List<String> lightGraphs = ['UV', 'Espectre'];
  List<String> soundGraphs = ['dbSPL'];

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]).then((_) {
      super.initState();
    });
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]).then((_) {
      super.dispose();
    });
  }
  Widget XAxisTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget YAxisTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontSize: 10,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  @override
  Widget build(BuildContext context) {
    //We have to recover the info from the station
    GraphsGenerator generatorGraphs = GraphsGenerator();

    Object? data = ModalRoute.of(context)?.settings.arguments;
    station = data as StationModel;
    if (selectedTitleGraphs == "nope") {
      selectedTitleGraphs = "Meteorología";
    }
    //We need to select the subtitle graphs
    //['METEO', 'CONTAMINANTS', 'PARTÍCULES', 'LLUM', 'SO'];
    //Nomes cal fer això si es la primera vegada o si hem cambiat el titol principal
    if (selectedSubTitleGraphs == "nope" ||
        (lastTitle != selectedTitleGraphs)) {
      if (selectedSubTitleGraphs == "nope") {
        lastTitle = "Meteorología";
      }
      if (selectedTitleGraphs == "Meteorología") {
        subTitle = meteoGraphs;
        lastTitle = "Meteorología";
        selectedSubTitleGraphs = "Temperatura";
      } else if (selectedTitleGraphs == "Contaminants") {
        subTitle = pollutionsGraphs;
        lastTitle = "Contaminants";
        selectedSubTitleGraphs = "CO";
      } else if (selectedTitleGraphs == "Partícules") {
        subTitle = particlesGraphs;
        lastTitle = "Partícules";
        selectedSubTitleGraphs = "PM 2.5";
      } else if (selectedTitleGraphs == "Llum") {
        subTitle = lightGraphs;
        lastTitle = "Llum";
        selectedSubTitleGraphs = "UV";
      } else {
        subTitle = soundGraphs;
        lastTitle = "So";
        selectedSubTitleGraphs = "dbSPL";
      }
    }

    //Quan tenim el titol i el subtitol posem extraiem les dades coresponents i generem els valors
    //Nova classe GraphsGenerator


    List<FlSpot> listSpots = generatorGraphs.getDataForGraph(station, selectedTitleGraphs, selectedSubTitleGraphs, 24);
    print("Expected: ${3*12} Real: ${listSpots.length}");



    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 1,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    8, MediaQuery.of(context).size.height * 0.15, 8, 8),
                child: LineChart(LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    horizontalInterval: generatorGraphs.getInterval(listSpots),
                    verticalInterval: 10,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.black,
                        strokeWidth: 0.5,
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: Colors.black,
                        strokeWidth: 0.5,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 23,
                        interval: 10,
                        getTitlesWidget: XAxisTitles,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: YAxisTitles,
                        reservedSize: 23,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.black, width: 0.75),
                  ),
                  minX: 1,
                  maxX: listSpots.length.toDouble(),
                  minY: generatorGraphs.getMinY(listSpots),
                  maxY: generatorGraphs.getMaxY(listSpots),
                  lineBarsData: [
                    LineChartBarData(
                      spots: listSpots,
                      isCurved: true,
                      gradient: const LinearGradient(
                        colors: [
                           Color(0xff23b6e6),
                           Color(0xff02d39a),
                        ],
                      ),
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: false,
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xff23b6e6),
                            const Color(0xff02d39a),
                          ].map((color) => color.withOpacity(0.4)).toList(),
                        ),
                      ),
                    ),
                  ],
                )),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 30, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          //border: Border.all(color: Colors.black, width: 1),
                          color: Colors.blueGrey.shade400,
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
                            value: selectedTitleGraphs,
                            onChanged: (String? newValue) {
                              setState(() {
                                //Repaint graphic
                                lastTitle = selectedTitleGraphs;
                                selectedTitleGraphs = newValue!;
                              });
                            },
                            items: firstTitle.map((String titleGraphs) {
                              return DropdownMenuItem<String>(
                                value: titleGraphs,
                                child: Text(titleGraphs,
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
                    Container(
                      width: 105,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        //border: Border.all(color: Colors.black, width: 1),
                        color: Colors.blueGrey.shade400,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropdownButton(
                              underline: Container(),
                              alignment: AlignmentDirectional.center,
                              elevation: 8,
                              iconSize: 20,
                              icon: const Icon(
                                Icons.arrow_drop_down_circle_outlined,
                                color: Colors.black,
                              ),
                              value: selectedSubTitleGraphs,
                              onChanged: (String? newValue) {
                                setState(() {
                                  //Repaint graphic
                                  selectedSubTitleGraphs = newValue!;
                                });
                              },
                              items: subTitle.map((String graphs) {
                                return DropdownMenuItem<String>(
                                  value: graphs,
                                  child: Text(graphs,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      )),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  backgroundColor: Colors.blueGrey.shade400,
                  onPressed: () {
                    //We go back to detail station
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
