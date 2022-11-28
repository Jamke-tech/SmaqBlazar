import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class TimeAnalizer{

  String getActualizationTime(String dataNotParsed){
    String result = "NO DATA";
    String update = "";
    DateTime data = DateTime.parse(dataNotParsed.replaceAll("/", "-"));

    Duration timeSpace = DateTime.now().difference(data);

    if(timeSpace.inDays>=1){
      update = "${timeSpace.inDays.toString()} ${timeSpace.inDays == 1 ? "dia" : "dies"}   ";
    }else{
      if(timeSpace.inMinutes>60){
        update = "${timeSpace.inHours.toString()} ${timeSpace.inHours == 1 ? "hora" : "hores"}   ";

      }else{
        update = "${timeSpace.inMinutes.toString()} ${timeSpace.inMinutes == 1 ? "minut" : "minuts"}   ";
      }

    }
    result = "Última actualització fa $update";
    return result;
  }
  String getDateTimeInLocal (String dataNotParsed){
    String result = "NO DATA";
    DateTime data = DateFormat("yyyy/MM/dd HH:mm:ssZ").parse(dataNotParsed,true);
    DateTime local = data.toLocal();
    if(local.minute<10){
      result = "Última actualització: ${local.day}/${local.month}/${local.year} a les ${local.hour}:0${local.minute}";

    }else{
      result = "Última actualització: ${local.day}/${local.month}/${local.year} a les ${local.hour}:${local.minute}";

    }
    return result;
  }
  String getDateTimeInLocalHourMinute (String dataNotParsed){
    String result = "NO DATA";
    DateTime data = DateFormat("yyyy/MM/dd HH:mm:ssZ").parse(dataNotParsed,true);
    DateTime local = data.toLocal();
    if(local.minute<10){
      result = "${local.hour}:0${local.minute}";
    }else{
      result = "${local.hour}:${local.minute}";
    }

    return result;
  }















}