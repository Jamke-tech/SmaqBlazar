import 'package:SMAQ/classes/station_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GraphsGenerator {
  //Class to generate all the information for the graphs generation


  List<FlSpot> getDataForGraph(StationModel station, String selectedTitleGraphs,
      String selectedSubTitleGraphs, int maxTime) {
    //We need to show the maximum data for the title and the SubTitle
    List<FlSpot> vectorData = [];
    if(station.lastData.isNotEmpty && station.lastData.length > 1 ) {
      DateTime lastDataTime = DateTime.parse(
          station.lastData[0].CreationDate.replaceAll("/", "-"));
      DateTime actualDataTime = lastDataTime;
      int loop = 0;

      int maxNum = loop;
      int lupilupi=0;
      //Trobem el maxim de dades
      while ( actualDataTime
          .difference(lastDataTime)
          .inHours < maxTime && lupilupi < station.lastData.length -1) {
        print(actualDataTime
            .difference(lastDataTime)
            .inHours);

        maxNum++;
        lastDataTime=DateTime.parse(
            station.lastData[lupilupi+1].CreationDate.replaceAll("/", "-"));
        lupilupi++;
      }
      print(lupilupi);
      print(maxNum);




      if (selectedTitleGraphs == "Meteorología") {
        if (selectedSubTitleGraphs == "Temperatura") {
          while ( loop<maxNum) {
            //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
            vectorData.add(
                FlSpot(lupilupi.toDouble(), station.lastData[loop].Temperature));
            lupilupi--;
            loop++;
          }
        }else if(selectedSubTitleGraphs=="Humitat"){
          while ( loop<maxNum) {
            //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
            vectorData.add(
                FlSpot(lupilupi.toDouble(), station.lastData[loop].Humidity));
            lupilupi--;
            loop++;
          }
        }else if(selectedSubTitleGraphs=="Pressió"){
          while ( loop<maxNum) {
            //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
            vectorData.add(
                FlSpot(lupilupi.toDouble(), station.lastData[loop].Pressure));
            lupilupi--;
            loop++;
          }
        }else{
          while ( loop<maxNum) {
            //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
            vectorData.add(
                FlSpot(lupilupi.toDouble(), station.lastData[loop].Rain));
            lupilupi--;
            loop++;
          }
        }
      } else if (selectedTitleGraphs == "Contaminants") {
        if(selectedSubTitleGraphs=="CO"){
          while ( loop<maxNum) {
            //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
            vectorData.add(
                FlSpot(lupilupi.toDouble(), station.lastData[loop].CxCO));
            lupilupi--;
            loop++;
          }
        }else if (selectedSubTitleGraphs=="O3"){
          while ( loop<maxNum) {
            //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
            vectorData.add(
                FlSpot(lupilupi.toDouble(), station.lastData[loop].CxO3));
            lupilupi--;
            loop++;
          }
        }else if(selectedSubTitleGraphs=="NO2"){
          while ( loop<maxNum) {
            //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
            vectorData.add(
                FlSpot(lupilupi.toDouble(), station.lastData[loop].CxNO2));
            lupilupi--;
            loop++;
          }
        }else{
          while ( loop<maxNum) {
            //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
            vectorData.add(
                FlSpot(lupilupi.toDouble(), station.lastData[loop].CxSO2));
            lupilupi--;
            loop++;
          }
        }
      } else if (selectedTitleGraphs == "Partícules") {
        if(selectedSubTitleGraphs=="PM 2.5"){
          while ( loop<maxNum) {
            //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
            vectorData.add(
                FlSpot(lupilupi.toDouble(), station.lastData[loop].PM25.toDouble()));
            lupilupi--;
            loop++;
          }
        }else{
          while ( loop<maxNum) {
            //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
            vectorData.add(
                FlSpot(lupilupi.toDouble(), station.lastData[loop].PM10.toDouble()));
            lupilupi--;
            loop++;
          }
        }

      } else if (selectedTitleGraphs == "Llum") {
        if(selectedSubTitleGraphs=="UV"){
          while ( loop<maxNum) {
            //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
            vectorData.add(
                FlSpot(lupilupi.toDouble(), station.lastData[loop].UV.toDouble()));
            lupilupi--;
            loop++;
          }
        }else{
          while (loop<maxNum) {
            //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
            vectorData.add(
                FlSpot(lupilupi.toDouble(), station.lastData[loop].RedLux));
            lupilupi--;
            loop++;
          }
        }
      } else {
        while ( loop<maxNum) {
          //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
          vectorData.add(
              FlSpot(lupilupi.toDouble(), station.lastData[loop].Sound));
          lupilupi--;
          loop++;
        }
      }

      return
        vectorData.reversed.toList();
    }
    else{
      return [];
    }
  }


  double getMaxY(List<FlSpot> list){

    int i =0;
    int maxY=0;

    while(i<list.length){
      if(list[i].y>maxY){
        maxY=list[i].y.toInt();
      }
      i++;

    }

    //We refactor the value to not be the maximum
    //We add a 20% margin for maximum value
    double maxRealY;
    if(maxY*1.2 > maxY+2){
       maxRealY= (maxY).toInt().toDouble() +2;
    }else{
      maxRealY = (maxY*1.2).toInt().toDouble() ;
    }



    if(maxRealY<4){
      maxRealY=4.0;
    }
    return maxRealY;

  }
  double getMinY(List<FlSpot> list){

    int i =0;
    int minY=getMaxY(list).toInt();

    while(i<list.length){
      if(list[i].y<minY){
        minY=list[i].y.toInt();
      }
      i++;

    }

    //We refactor the value to not be the maximum
    //We add a 20% margin for maximum value
    double minRealY = (minY).toInt().toDouble() -1;
    if(minRealY<0){
      minRealY=0.0;
    }
    return minRealY;

  }
  double getInterval(List<FlSpot> listSpots){
    double interval = ((getMaxY(listSpots) -getMinY(listSpots))~/15).toDouble();
    print("interval: $interval");
    if(interval<4){
      interval=1;
    }
    print(interval);
    return interval;

  }




}