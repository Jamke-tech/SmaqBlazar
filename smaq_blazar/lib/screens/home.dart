import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:smaq_blazar/classes/station.dart';
import 'package:smaq_blazar/widgets/Icon_map.dart';
import 'package:smaq_blazar/widgets/floating_legend.dart';

import '../widgets/floating_add.dart';
import '../widgets/floating_info.dart';

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}



class _HomeState extends State<Home> {
  int _counter = 0;

  bool satellite=false;
  late Station stationShown = Station("null",0,0,0,0,0,0);
  Color boxColor = Colors.lightGreen.shade800;
  bool addingStation = false;
  bool showingInfo=false;
  bool showingLegend = false;

  List<Station> StationList = [
    Station("FOC Wallbox Office",41.35581,2.14141,223,25.6,48.7,1015.2),
    Station("Castell de Montjüic",41.364879,2.148868,15,25.4,49,1014.2),
    Station("D26 Wallbox Factory",41.32723,2.12849,110,27,52.6,1015.7),
    Station("Plaça Espanya",41.37505,2.14922,172,28,51.5,1013.8)
  ];

  List<Marker> markersList = [ ];
  @override
  Widget build(BuildContext context) {

    for ( Station station in StationList){
      markersList.add(
        Marker(
          point: LatLng(station.lat,station.long),
          width:20,
          height: 20,
          rotate: true,
          builder: (context){

            //We have to set the color of the box
            int AqiLevel = station.AqiLevel;
            Color colorSelected = Color(0xFF7D0023);

            if(AqiLevel <= 50 ){
              colorSelected=Colors.lightGreen.shade800;
            }else if(AqiLevel>50 && AqiLevel<=100){
              colorSelected=Colors.amber;
            }else if(AqiLevel>100 && AqiLevel<=150){
              colorSelected=Colors.orange.shade800;
            }else if(AqiLevel>150 && AqiLevel<=200){
              colorSelected=Colors.redAccent.shade700;
            }else if(AqiLevel>200 && AqiLevel<=300){
              colorSelected=Colors.pink.shade800;
            }else{
              colorSelected=Color(0xFF7D0023);
            }

            return IconMap(
            Iconcolor: colorSelected,
            setStateforMap: (){
              //Fucntion to setState of map and change the values of the shown card
              setState(() {
                stationShown = station;
                boxColor= colorSelected;
              });


            },
          );}
        ),
      );

    }


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
                        borderRadius: showingInfo ? (showingLegend? (BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),bottomLeft: Radius.zero,bottomRight: Radius.circular(20))) : (BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),bottomLeft: Radius.circular(20),bottomRight: Radius.zero) )): BorderRadius.circular(20),
                        border: Border.all(color: Colors.black,width: 2),
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

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: showingInfo && !showingLegend ? Container() : (stationShown.name == "null" ? Container(): FloatInfo( station: stationShown , boxcolor: boxColor,)),
            ),
          ),
        ]
      ),
      /*floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: FloatInfo( ),
          ))// This trailing comma makes auto-formatting nicer for build methods.

          Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black,width: 4),
                      color: Colors.teal.shade400,

                    ),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.95,
                    height:  MediaQuery
                        .of(context)
                        .size
                        .height * 0.05
                    ,
                    child: Text(
                      "Clica a un punt per més info"
                    ),

                  ),*/
    );
  }
}