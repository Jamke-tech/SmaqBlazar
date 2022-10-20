
import 'dart:ffi';

class Station{

  String name;
  String IDStation;
  String Description;
  String Picture;
  double lat;
  double long;

  int AqiLevel;
  double temp;
  double humidity;
  double pressure;

  Station(this.IDStation, this.Description,this.Picture,this.name, this.lat, this.long, this.AqiLevel, this.temp,
      this.humidity, this.pressure);


}