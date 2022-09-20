import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:smaq_blazar/widgets/Icon_map.dart';

import '../widgets/floating_info.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}



class _HomeState extends State<Home> {
  int _counter = 0;

  List<Marker> markersList = [
    Marker(
      point: LatLng(41.35581,2.14141),
      width:20,
      height: 20,
      rotate: true,
      builder: (context)=> IconMap(
        Iconcolor: Colors.amber,
      ),
    ),
    Marker(
      point: LatLng(41.37,2.14141),
      width:20,
      height: 20,
      rotate: true,
      builder: (context)=> IconMap(
        Iconcolor: Colors.red,
      ),
    ),
    Marker(
      point: LatLng(41.364,2.15),
      width:20,
      height: 20,
      rotate: true,
      builder: (context)=> IconMap(
        Iconcolor: Colors.lightGreen,
      ),
    ),
    Marker(
      point: LatLng(41.45,2.15),
      width:20,
      height: 20,
      rotate: true,
      builder: (context)=> IconMap(
        Iconcolor: Colors.amber,
      ),
    )


  ];













  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Stack(
        children:[
          SafeArea(
              child: Center(
                child: FlutterMap(
                    options: MapOptions(
                      //Donde estarà el mapa centrado
                        center: LatLng( 41.35581 , 2.14141),
                        minZoom: 5,
                        zoom: 14,
                        plugins: [
                          MarkerClusterPlugin(),
                        ]
                    ),
                    /*nonRotatedChildren: [
                AttributionWidget.defaultWidget(
                  source: 'OpenStreetMap contributors',
                  onSourceTapped: null,
                ),
              ],*/
                    layers: [
                      TileLayerOptions(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                      MarkerClusterLayerOptions(
                        maxClusterRadius: 120,
                        size: Size(30,30),
                        fitBoundsOptions: FitBoundsOptions(
                          padding:EdgeInsets.all(40),
                        ),
                        //TODO This List is the stations list from the server ( Only get the near ones)
                        markers: markersList,
                        builder: (context, markers) {
                          return  FloatingActionButton(
                            onPressed: null,
                            child: Text(markers.length.toString()),
                          );
                        },

                      )
                    ]),
              )
          ),

          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black,width: 4
                    ),
                    color: Colors.teal.shade400,

                  ),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9,
                  height: 60,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          color: Colors.white,
                          hoverColor: Colors.red,
                            highlightColor: Colors.red,
                            splashColor: Colors.red,

                            onPressed: (){
                            print("hello i am info button");

                            },
                            icon: Icon(Icons.info_outline_rounded,
                            size: 35,
                            )),

                        IconButton(
                            onPressed: (){

                            },
                            icon: Icon(Icons.satellite_rounded,
                            size:35,
                                color: Colors.white)),

                        IconButton(
                            onPressed: (){

                            },
                            icon: Icon(Icons.filter_alt_rounded,
                            size: 35,
                            color: Colors.white)),

                        IconButton(
                            onPressed: (){

                            },
                            icon: Icon(Icons.add_box_outlined,
                            size:35,
                            color: Colors.white)),

                      ],



                    ),
                  ),

                ),
              ),
            ),
          ),
        ]
      ),
      floatingActionButton: FloatInfo( )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}