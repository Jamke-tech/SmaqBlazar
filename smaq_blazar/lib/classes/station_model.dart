import 'dart:ffi';

class StationModel{

  String name;
  String IDStation;
  String Description;
  //String Picture;
  double lat;
  double long;

  StationModel({
      required this.name, required this.IDStation, required this.Description, required this.lat, required this.long});
}