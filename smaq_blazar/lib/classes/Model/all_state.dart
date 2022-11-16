class AllState {
  //Model to get the info from OpenSky api
  //Info from : https://openskynetwork.github.io/opensky-api/rest.html
  final String icao24;
  final String callSign;
  final int timePosition;
  final double long;
  final double lat;
  final double baroAltitude;
  final bool onGround;
  final double geoAltitude;
  final int category;


  AllState({required this.icao24,
      required this.callSign,
      required this.timePosition,
      required this.long,
      required this.lat,
      required this.baroAltitude,
      required this.onGround,
      required this.geoAltitude,
  required this.category});

  factory AllState.fromJson(dynamic json){
    if (json == null) {
      return AllState(
          icao24:"000",
          callSign:"NONE",
          timePosition:0,
          long:0,
          lat:0,
          baroAltitude:-1,
          onGround:true,
          geoAltitude:-1,
          category: 0);

    }
    return AllState(
      icao24: json[0] ,
      callSign: (null!=json[1])?json[1]:"No CallSign",
      timePosition:(null!=json[3])?json[3]:0,
      long:(null!=json[5])? double.parse(json[5].toString()):0,
      lat:(null!=json[6])?double.parse(json[6].toString()):0,
      baroAltitude:(null!=json[7])?double.parse(json[7].toString()):0,
      onGround:(null!=json[8])?json[8]:true,
      geoAltitude:(null!=json[13])?double.parse(json[13].toString()):0,
      category: json[17],
    );
  }


}