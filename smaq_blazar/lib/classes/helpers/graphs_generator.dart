import 'dart:io';

import 'package:SMAQ/classes/Model/station_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:syncfusion_officechart/officechart.dart';

class GraphsGenerator {
  //Class to generate all the information for the graphs generation

  Widget textAxis = Container();
  String titleAxis = "no TITLE";

  List<DateTime> listForDates = [];
  List<double> listForValues = [];




  List<FlSpot> getDataForGraph(StationModel station, String selectedTitleGraphs,
      String selectedSubTitleGraphs, int maxTime) {
    //We need to show the maximum data for the title and the SubTitle
    List<FlSpot> vectorData = [];
    //we clean the vectors
    listForValues=[];
    listForDates=[];

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


        maxNum++;
        lastDataTime=DateTime.parse(
            station.lastData[lupilupi+1].CreationDate.replaceAll("/", "-"));
        lupilupi++;
      }

      if (selectedTitleGraphs == "Meteorología") {
        if (selectedSubTitleGraphs == "Temperatura") {
          while ( loop<maxNum) {
            //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
            vectorData.add(
                FlSpot(lupilupi.toDouble(), station.lastData[loop].Temperature));
            listForValues.add(station.lastData[loop].Temperature);
            listForDates.add(DateTime.parse(station.lastData[loop].CreationDate.replaceAll("/", "-")));

            lupilupi--;
            loop++;
          }
          textAxis = const Text(
            "Temperatura (ºC)"
          );
          titleAxis = "Temperatura (ºC)";
        }else if(selectedSubTitleGraphs=="Humitat"){
          while ( loop<maxNum) {
            //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
            vectorData.add(
                FlSpot(lupilupi.toDouble(), station.lastData[loop].Humidity));
            listForValues.add(station.lastData[loop].Humidity);
            listForDates.add(DateTime.parse(station.lastData[loop].CreationDate.replaceAll("/", "-")));
            lupilupi--;
            loop++;
          }
          textAxis = const Text(
              "Humitat (%)"
          );
          titleAxis = "Humitat (%)";
        }else if(selectedSubTitleGraphs=="Pressió"){
          while ( loop<maxNum) {
            //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
            vectorData.add(
                FlSpot(lupilupi.toDouble(), station.lastData[loop].Pressure));
            listForValues.add(station.lastData[loop].Pressure);
            listForDates.add(DateTime.parse(station.lastData[loop].CreationDate.replaceAll("/", "-")));
            lupilupi--;
            loop++;
          }
          textAxis = const Text(
              "Pressió (hPa)"
          );
          titleAxis = "Pressió (hPa)";
        }else{
          while ( loop<maxNum) {
            //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
            vectorData.add(
                FlSpot(lupilupi.toDouble(), station.lastData[loop].Rain));
            listForValues.add(station.lastData[loop].Rain);
            listForDates.add(DateTime.parse(station.lastData[loop].CreationDate.replaceAll("/", "-")));
            lupilupi--;
            loop++;
          }
          textAxis = const Text(
              "Pluja (mm)");
          titleAxis = "Pluja (mm)";
        }


      } else if (selectedTitleGraphs == "Contaminants") {
        if(selectedSubTitleGraphs=="CO"){
          while ( loop<maxNum) {
            //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
            vectorData.add(
                FlSpot(lupilupi.toDouble(), station.lastData[loop].CxCO));
            listForValues.add(station.lastData[loop].CxCO);
            listForDates.add(DateTime.parse(station.lastData[loop].CreationDate.replaceAll("/", "-")));
            lupilupi--;
            loop++;
          }
          textAxis = const Text(
              "Cx CO (ppm)"
          );
          titleAxis = "Cx CO (ppm)";
        }else if (selectedSubTitleGraphs=="O3"){
          while ( loop<maxNum) {
            //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
            vectorData.add(
                FlSpot(lupilupi.toDouble(), station.lastData[loop].CxO3));
            listForValues.add(station.lastData[loop].CxO3);
            listForDates.add(DateTime.parse(station.lastData[loop].CreationDate.replaceAll("/", "-")));
            lupilupi--;
            loop++;
          }
          textAxis = const Text(
              "Cx O3 (ppm)"
          );
          titleAxis = "Cx O3 (ppm)";
        }else if(selectedSubTitleGraphs=="NO2"){
          while ( loop<maxNum) {
            //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
            vectorData.add(
                FlSpot(lupilupi.toDouble(), station.lastData[loop].CxNO2));
            listForValues.add(station.lastData[loop].CxNO2);
            listForDates.add(DateTime.parse(station.lastData[loop].CreationDate.replaceAll("/", "-")));
            lupilupi--;
            loop++;
          }
          textAxis = const Text(
              "Cx NO2 (ppm)"
          );
          titleAxis = "Cx NO2 (ppm)";
        }else{
          while ( loop<maxNum) {
            //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
            vectorData.add(
                FlSpot(lupilupi.toDouble(), station.lastData[loop].CxSO2));
            listForValues.add(station.lastData[loop].CxSO2);
            listForDates.add(DateTime.parse(station.lastData[loop].CreationDate.replaceAll("/", "-")));
            lupilupi--;
            loop++;
          }
          textAxis = const Text(
              "Cx SO2 (ppm)"
          );
          titleAxis = "Cx SO2 (ppm)";
        }

      } else if (selectedTitleGraphs == "Partícules") {
        if(selectedSubTitleGraphs=="PM 2.5"){
          while ( loop<maxNum) {
            //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
            vectorData.add(
                FlSpot(lupilupi.toDouble(), station.lastData[loop].PM25.toDouble()));
            listForValues.add(station.lastData[loop].PM25.toDouble());
            listForDates.add(DateTime.parse(station.lastData[loop].CreationDate.replaceAll("/", "-")));
            lupilupi--;
            loop++;
          }
          textAxis = const Text(
              "PM 2.5 (ug/m3)"
          );
          titleAxis = "PM 2.5 (ug/m3)";
        }else{
          while ( loop<maxNum) {
            //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
            vectorData.add(
                FlSpot(lupilupi.toDouble(), station.lastData[loop].PM10.toDouble()));
            listForValues.add(station.lastData[loop].PM10.toDouble());
            listForDates.add(DateTime.parse(station.lastData[loop].CreationDate.replaceAll("/", "-")));
            lupilupi--;
            loop++;
          }
          textAxis = const Text(
              "PM 10 (ug/m3)"
          );
          titleAxis = "PM 10 (ug/m3)";
        }

      } else if (selectedTitleGraphs == "Llum") {
        if(selectedSubTitleGraphs=="UV"){
          while ( loop<maxNum) {
            //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
            vectorData.add(
                FlSpot(lupilupi.toDouble(), station.lastData[loop].UV.toDouble()));
            listForValues.add(station.lastData[loop].UV.toDouble());
            listForDates.add(DateTime.parse(station.lastData[loop].CreationDate.replaceAll("/", "-")));
            lupilupi--;
            loop++;
          }
          textAxis = const Text(
              "UV Index "
          );
          titleAxis = "UV Index";
        }else if(selectedSubTitleGraphs=="Intensitat R"){
          while (loop<maxNum) {
            //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
            vectorData.add(
                FlSpot(lupilupi.toDouble(), station.lastData[loop].RedLux));
            listForValues.add(station.lastData[loop].RedLux);
            listForDates.add(DateTime.parse(station.lastData[loop].CreationDate.replaceAll("/", "-")));
            lupilupi--;
            loop++;
          }
          textAxis = const Text(
              "Llum vermella (lux)"
          );
          titleAxis = "Llum vermella (lux)";
        }else if(selectedSubTitleGraphs=="Intensitat B"){
          while (loop<maxNum) {
            //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
            vectorData.add(
                FlSpot(lupilupi.toDouble(), station.lastData[loop].BlueLux));
            listForValues.add(station.lastData[loop].BlueLux);
            listForDates.add(DateTime.parse(station.lastData[loop].CreationDate.replaceAll("/", "-")));
            lupilupi--;
            loop++;
          }
          textAxis = const  Text(
              "Llum blava (lux)"
          );
          titleAxis = "Llum blava (lux)";
        }else if(selectedSubTitleGraphs=="Intensitat G"){
          while (loop<maxNum) {
            //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
            vectorData.add(
                FlSpot(lupilupi.toDouble(), station.lastData[loop].GreenLux));
            listForValues.add(station.lastData[loop].GreenLux);
            listForDates.add(DateTime.parse(station.lastData[loop].CreationDate.replaceAll("/", "-")));
            lupilupi--;
            loop++;
          }
          textAxis = const  Text(
              "Llum verda (lux)"
          );
          titleAxis = "Llum verda (lux)";
        }else {
          while (loop<maxNum) {
            //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
            vectorData.add(
                FlSpot(lupilupi.toDouble(), station.lastData[loop].IR));
            listForValues.add(station.lastData[loop].IR);
            listForDates.add(DateTime.parse(station.lastData[loop].CreationDate.replaceAll("/", "-")));
            lupilupi--;
            loop++;
          }
          textAxis = const Text(
              "Llum infraroja (lux)"
          );
          titleAxis = "Llum infraroja (lux)";
        }
      } else {
        while ( loop<maxNum) {
          //Afegeixo totes les dades fins que no tinc mes o fins que el temps no es el que poso
          vectorData.add(
              FlSpot(lupilupi.toDouble(), station.lastData[loop].Sound));
          listForValues.add(station.lastData[loop].Sound);
          listForDates.add(DateTime.parse(station.lastData[loop].CreationDate.replaceAll("/", "-")));
          lupilupi--;
          loop++;
        }
        textAxis = const Text(
            "Intensitat sonora (dbSPL)"
        );
        titleAxis = "Intensitat sonora (dbSPL)";

      }

      /*listForDates=listForDates.reversed.toList();
      listForValues=listForValues.reversed.toList();*/

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
       maxRealY= (maxY).toInt().toDouble() +6;
    }else{
      maxRealY = (maxY*1.2).toInt().toDouble()  ;
    }
    if(maxRealY>20000){
      maxRealY=maxRealY+5000;
    }



     if(maxRealY<=3){
      maxRealY=3.0;
    }else if(maxRealY<=4){
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
    double minRealY = (minY).toInt().toDouble() -2;
    if(minRealY<0){
      minRealY=0.0;
    }
    return minRealY;

  }
  double getInterval(List<FlSpot> listSpots){
    double interval = ((getMaxY(listSpots) -getMinY(listSpots))~/15).toDouble();
    //print("interval: $interval");
    if(interval<1){
      interval=1;
    }else if (interval <2){
      interval =2;
    }
    //print(interval);
    return interval;

  }


  Future<void> generateExcelfromData() async {

    Workbook workbook = Workbook();
    Worksheet sheet = workbook.worksheets[0];
    Style globalStyle = workbook.styles.add('TitleStyle');
//set back color by hexa decimal.
    globalStyle.backColor = '#FFFFFF';
//set font name.
    globalStyle.fontName = 'Arial';
//set font size.
    globalStyle.fontSize = 20;
//set font color by hexa decimal.
    globalStyle.fontColor = '#000000';
//set font italic.
    globalStyle.italic = false;
//set font bold.
    globalStyle.bold = true;
//set font underline.
    globalStyle.underline = false;
//set wraper text.
    globalStyle.wrapText = true;
//set indent value.
    globalStyle.indent = 1;
//set horizontal alignment type.
    globalStyle.hAlign = HAlignType.center;
//set vertical alignment type.
    globalStyle.vAlign = VAlignType.bottom;
//set all border line style.
    globalStyle.borders.all.lineStyle = LineStyle.thin;


    //Omplim el excel amb les dades de Data i valor
    sheet.getRangeByName('A1').setText("Data (dia i Hora)");
    sheet.getRangeByName('A1').cellStyle = globalStyle;
    sheet.getRangeByName('B1').setText(titleAxis);
    sheet.getRangeByName('B1').cellStyle = globalStyle;

    //Omplim tots els valors a la taula
    int  pointer= 2;

    while(listForDates.length > pointer-2){

      sheet.getRangeByName('A$pointer').setDateTime(listForDates[pointer-2]);
      sheet.getRangeByName('B$pointer').setNumber(listForValues[pointer-2]);
      pointer ++;

    }

    sheet.autoFitColumn(1);
    sheet.autoFitColumn(2);



    List<int> bytes = workbook.saveAsStream();

    //Get the storage folder location using path_provider package.
    Directory? directory = await getApplicationDocumentsDirectory();

    //Get directory path
    String path = directory!.path;

    //Create an empty file to write Excel data
    String fullpath = '$path/${titleAxis}_fData_${DateTime.now().toString()}.xlsx';

    File file = File(fullpath);
    //Write Excel data
    await file.writeAsBytes(bytes, flush: true);
    //Launch the file (used open_file package)
    await OpenFile.open(fullpath);
    workbook.dispose();






  }









}