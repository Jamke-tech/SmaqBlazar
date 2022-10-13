
import 'dart:ffi';

class Station{

  String name;
  double lat;
  double long;

  int AqiLevel;
  double temp;
  double humidity;
  double pressure;

  Station(this.name, this.lat, this.long, this.AqiLevel, this.temp,
      this.humidity, this.pressure);


}