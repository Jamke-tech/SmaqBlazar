class DataStation {
  //Variables
  String StationID;
  String CreationDate;

  double Humidity;
  double Temperature;
  double Pressure;
  double Rain;

  double CxCO;
  double CxNO2;
  double CxO3;
  double CxSO2;

  int PM10;
  int PM25;

  double BlueLux;
  double GreenLux;
  double IR;
  double RedLux;
  int UV;
  String UVSource;

  double Sound;

  DataStation(
      {required this.StationID,
      required this.CreationDate,
      required this.Humidity,
      required this.Temperature,
      required this.Pressure,
      required this.Rain,
      required this.CxCO,
      required this.CxNO2,
      required this.CxO3,
      required this.CxSO2,
      required this.PM10,
      required this.PM25,
      required this.BlueLux,
      required this.GreenLux,
      required this.IR,
      required this.RedLux,
      required this.UV,
      required this.UVSource,
      required this.Sound});



  DataStation getDummy() {
    return DataStation(
        StationID: "ERROR",
        CreationDate: "ERROR",
        Humidity: 0,
        Temperature: 0,
        Pressure: 0,
        Rain: 0,
        CxCO: 0,
        CxNO2: 0,
        CxO3: 0,
        CxSO2: 0,
        PM10: 0,
        PM25: 0,
        BlueLux: 0,
        GreenLux: 0,
        IR: 0,
        RedLux: 0,
        UV: 0,
        UVSource: "0",
        Sound: 0);
  }
}
