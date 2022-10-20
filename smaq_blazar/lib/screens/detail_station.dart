import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:smaq_blazar/classes/station.dart';
import 'package:smaq_blazar/widgets/Icon_map.dart';
import 'package:smaq_blazar/widgets/floating_legend.dart';

import '../widgets/floating_add.dart';
import '../widgets/floating_info.dart';

class DetailStation extends StatefulWidget {

  @override
  State<DetailStation> createState() => _DetailStationState();
}



class _DetailStationState extends State<DetailStation> {
  int _counter = 0;

  bool satellite=false;

  Color boxColor = Colors.lightGreen.shade800;
  bool addingStation = false;
  bool showingInfo=false;
  bool showingLegend = false;



  List<Marker> markersList = [ ];
  @override
  Widget build(BuildContext context) {




    return Scaffold(
      body: Stack(
          children:[
            Center(
              child: FlutterMap(
                  options: MapOptions(
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
                      urlTemplate: satellite ? 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}' :'https://tile.openstreetmap.org/{z}/{x}/{y}.png' ,
                      subdomains: ['a', 'b', 'c'],
                      retinaMode:  true,
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

                    ),
                    //LocationMarkerLayerOptions(),
                  ]),
            ),

            Align(
              alignment: Alignment.topCenter,
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: showingInfo ? (showingLegend? (BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8),bottomLeft: Radius.zero,bottomRight: Radius.circular(8))) : (BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8),bottomLeft: Radius.circular(8),bottomRight: Radius.zero) )): BorderRadius.circular(8),
                          border: Border.all(color: Colors.black,width: 1),
                          color: Colors.grey.shade400,
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
                        height: 60,
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  color: (showingInfo&&addingStation )?Colors.grey.shade400:Colors.black,


                                  onPressed: (){
                                    if(!addingStation){
                                      setState(() {
                                        if(showingInfo && showingLegend){
                                          showingInfo= false;
                                        }else{
                                          showingInfo=true;
                                        }
                                        showingLegend= !showingLegend;

                                      });

                                    }},
                                  icon: Icon(
                                    showingLegend ? Icons.close_fullscreen_outlined :  Icons.info_outline_rounded,

                                    size: 35,
                                  )),

                              IconButton(
                                  onPressed: (){
                                    if(!showingInfo){
                                      setState(() {
                                        satellite = !satellite;
                                      });

                                    }},
                                  icon: Icon(
                                      satellite? Icons.map_rounded:Icons.satellite_rounded,
                                      size:35,
                                      color: showingInfo?Colors.grey.shade400:Colors.black  )),

                              IconButton(
                                  onPressed: (){
                                    if(!showingInfo){}

                                  },
                                  icon: Icon(Icons.filter_alt_rounded,
                                      size: 35,
                                      color: showingInfo?Colors.grey.shade400:Colors.black)),

                              IconButton(
                                  onPressed: (){
                                    if(!showingLegend){
                                      setState(() {
                                        if(showingInfo && addingStation){
                                          showingInfo= false;
                                        }else{
                                          showingInfo=true;
                                        }
                                        addingStation= !addingStation;

                                      });

                                    }},
                                  icon: Icon(
                                      addingStation ? Icons.close_fullscreen_outlined :  Icons.add_box_outlined,
                                      size:35,
                                      color: (showingInfo && showingLegend )?Colors.grey.shade400:Colors.black)),

                            ],



                          ),
                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: showingInfo? (addingStation  ? FloatAdd() : showingLegend ? FloatLegend() : Container() ) :  Container(),
                    ),




                  ],
                ),
              ),
            ),


          ]
      ),

    );
  }
}