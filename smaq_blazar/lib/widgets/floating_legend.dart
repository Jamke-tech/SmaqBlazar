import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class FloatLegend extends StatefulWidget {
  FloatLegend({super.key});

  @override
  State<FloatLegend> createState() => _FloatLegendState();
}

class _FloatLegendState extends State<FloatLegend> {

  @override
  Widget build(BuildContext context) {


    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
                            color: Colors.lightGreen.shade800,
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
                                      color: Colors.lightGreen.shade800,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(top:4),
                                  child: Text( "No hi ha perill per la salut.",
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
                            color: Colors.amber,
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
                                      color: Colors.amber,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(top:4),
                                  child: Text(
                                      "LLeu amenaça per a grups sensibles.",
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
                              color: Colors.orange.shade800,
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
                                        color: Colors.orange.shade800,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top:4),
                                    child: Text( "LLeugeres molèsties al respirar.",
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
                              color: Colors.redAccent.shade700,
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
                                        color: Colors.redAccent.shade700,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top:4),
                                    child: Text(
                                        "Greus problemes a grups sensibles.",
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
                              color: Colors.pink.shade800,
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
                                        color: Colors.pink.shade800,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top:4),
                                    child: Text( "Pot causar malalties cròniques o afectacions importants.",
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
                              color: Color(0xFF7D0023),
                              border: Border.all(width: 1, color: Colors.black),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("PERILLÓS: 300+",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF7D0023),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top:4),
                                    child: Text(
                                        "L'exposició prolongada pot causar morts prematures.",
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

            ],
          ),
        ));
  }
}
