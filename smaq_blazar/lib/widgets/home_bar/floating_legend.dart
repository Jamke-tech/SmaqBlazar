import 'package:SMAQ/classes/helpers/design_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:rainbow_color/rainbow_color.dart';

class FloatLegend extends StatefulWidget {
  FloatLegend({super.key});

  @override
  State<FloatLegend> createState() => _FloatLegendState();
}

class _FloatLegendState extends State<FloatLegend> {
  List<String> methods = ["Nivell de contaminació", 'Altitud de vol dels avions'];
  String valueLegend = "Nivell de contaminació";
  var rb =  const [
  Color(0xff8CE0B0),
  Color(0xff69debf),
    Color(0xff43c7da),
    Color(0xff2b8dd7),
    Color(0xff0d4694),
    Color(0xff0b1e5e),

  ];
  DesignHelper design = DesignHelper();
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
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
          child: valueLegend == "Nivell de contaminació" ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
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
                    padding: const EdgeInsets.fromLTRB(16, 2, 2, 2),
                    child: DropdownButton(
                      underline: Container(),
                      elevation: 8,
                      iconSize: 20,
                      alignment: AlignmentDirectional.center,
                      icon: const Icon(
                        Icons.arrow_drop_down_circle_outlined,
                        color: Color(0xff00877F),
                      ),
                      value: valueLegend,
                      onChanged: (String? newValue) {
                        setState(() {
                          //Repaint graphic
                          valueLegend = newValue!;
                        });
                      },
                      items: methods.map((String methods) {
                        return DropdownMenuItem<String>(
                          value: methods,
                          child: Text(methods,
                              style: const TextStyle(
                                fontSize: 19,
                                color: Color(0xff00877F),
                              )),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: design.colorAQI(10),
                            border: Border.all(width: 1, color: Colors.black),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("BO:  0 - 50 ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: design.colorAQI(10),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(top:4),
                                  child: Text( design.textAQI(10),
                                      style: const TextStyle(
                                        fontSize: 10,
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
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: design.colorAQI(60),
                            border: Border.all(width: 1, color: Colors.black),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("MODERAT: 51 - 100",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: design.colorAQI(60),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(top:4),
                                  child: Text(
                                      design.textAQI(60),
                                      style: const TextStyle(
                                        fontSize: 10,
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
              Padding(
                padding: const EdgeInsets.only(top:4),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: design.colorAQI(110),
                              border: Border.all(width: 1, color: Colors.black),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("POBRE:  101 - 150 ",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: design.colorAQI(110),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top:4),
                                    child: Text( design.textAQI(110),
                                        style: const TextStyle(
                                          fontSize: 10,
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
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: design.colorAQI(160),
                              border: Border.all(width: 1, color: Colors.black),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("INSALUBRE: 151 - 200",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: design.colorAQI(160),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top:4),
                                    child: Text(
                                        design.textAQI(160),
                                        style: const TextStyle(
                                          fontSize: 10,
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
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: design.colorAQI(250),
                              border: Border.all(width: 1, color: Colors.black),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("SEVER:  201 - 300 ",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: design.colorAQI(250),
                                      )),
                                 Padding(
                                    padding: const EdgeInsets.only(top:4),
                                    child: Text( design.textAQI(260),
                                        style: const TextStyle(
                                          fontSize: 10,
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
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: design.colorAQI(400),
                              border: Border.all(width: 1, color: Colors.black),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  Text("PERILLÓS: 300+",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: design.colorAQI(400),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top:4),
                                    child: Text(
                                        design.textAQI(400),
                                        style: const TextStyle(
                                          fontSize: 10,
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


            ],
          ) : Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                    padding: const EdgeInsets.fromLTRB(16, 2, 2, 2),
                    child: DropdownButton(
                      underline: Container(),
                      elevation: 8,
                      iconSize: 20,
                      alignment: AlignmentDirectional.center,
                      icon: const Icon(
                        Icons.arrow_drop_down_circle_outlined,
                        color: Color(0xff00877F),
                      ),
                      value: valueLegend,
                      onChanged: (String? newValue) {
                        setState(() {
                          //Repaint graphic
                          valueLegend = newValue!;
                        });
                      },
                      items: methods.map((String methods) {
                        return DropdownMenuItem<String>(
                          value: methods,
                          child: Text(methods,
                              style: const TextStyle(
                                fontSize: 19,
                                color: Color(0xff00877F),
                              )),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Icon(Icons.airplanemode_on_rounded,
                          color: rb[0],


                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("0 - 100 m ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    )),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Icon(Icons.airplanemode_on_rounded,
                          color: rb[1],


                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("100 - 300 m ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    )),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top:4),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Icon(Icons.airplanemode_on_rounded,
                            color: rb[2],


                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("300 - 600 m ",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      )),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Icon(Icons.airplanemode_on_rounded,
                            color: rb[3],


                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("600 - 1000 m ",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      )),

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
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Icon(Icons.airplanemode_on_rounded,
                            color: rb[4],


                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("1000 - 1500 m ",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      )),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Icon(Icons.airplanemode_on_rounded,
                            color: rb[5],


                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("1500 - 2500 m ",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      )),

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


            ],
          ),
        ));
  }
}
