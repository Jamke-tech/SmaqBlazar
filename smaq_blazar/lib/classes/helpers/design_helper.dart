import 'package:flutter/material.dart';



class DesignHelper {

  Color colorAQI(int AqiLevel) {
    //print("Selecting color for: ${AqiLevel}");

    Color colorSelected = Color(0xFF7D0023);
    if (AqiLevel == -1) {
      colorSelected = Colors.blueGrey.shade400;
    } else if (AqiLevel <= 50) {
      colorSelected = Colors.lightGreen.shade800;
    } else if (AqiLevel > 50 && AqiLevel <= 100) {
      colorSelected = Colors.amber;
    } else if (AqiLevel > 100 && AqiLevel <= 150) {
      colorSelected = Colors.orange.shade800;
    } else if (AqiLevel > 150 && AqiLevel <= 200) {
      colorSelected = Colors.redAccent.shade700;
    } else if (AqiLevel > 200 && AqiLevel <= 300) {
      colorSelected = Colors.pink.shade800;
    } else {
      colorSelected = Color(0xFF7D0023);
    }

    return colorSelected;
  }

  String textAQI(int AqiLevel) {
    //print("Selecting color for: ${AqiLevel}");

    String Aqitext = "No hi ha perill per la salut.";
    if (AqiLevel <= 50) {
      Aqitext = "No hi ha perill per la salut.";
    } else if (AqiLevel > 50 && AqiLevel <= 100) {
      Aqitext = "Lleu amenaça per a grups sensibles.";
    } else if (AqiLevel > 100 && AqiLevel <= 150) {
      Aqitext = "Lleugeres molèsties al respirar.";
    } else if (AqiLevel > 150 && AqiLevel <= 200) {
      Aqitext = "Greus problemes a grups sensibles.";
    } else if (AqiLevel > 200 && AqiLevel <= 300) {
      Aqitext = "Pot causar malalties cròniques o afectacions importants.";
    } else {
      Aqitext = "L'exposició prolongada pot causar morts prematures.";
    }

    return Aqitext;
  }
  String textAQIExtended(int AqiLevel) {
    //print("Selecting color for: ${AqiLevel}");

    String Aqitext = "La qualitat de l'aire es considera satisfactòria i la contaminació atmosfèrica presenta un risc escàs o nul.";
    if (AqiLevel <= 50) {
      Aqitext = "La qualitat de l'aire es considera satisfactòria i la contaminació atmosfèrica presenta un risc escàs o nul.";
    } else if (AqiLevel > 50 && AqiLevel <= 100) {
      Aqitext = "La qualitat de l'aire és acceptable, però per alguns contaminants podria existir una lleu amenaça per a la salut de grups sensibles.";
    } else if (AqiLevel > 100 && AqiLevel <= 150) {
      Aqitext = "Els membres de grups sensibles comencen a sentir efectes a la salut. Tanmateix, tota la població pot començar a notar molèsties en respirar.";
    } else if (AqiLevel > 150 && AqiLevel <= 200) {
      Aqitext = "Tota la població té altes possibilitats de patir problemes en la salut amb espacial atenció a grups sensibles que poden desembocar en greus problemes.";
    } else if (AqiLevel > 200 && AqiLevel <= 300) {
      Aqitext = "Advertència sanitària de condicions d'emergència, tota la població pot patir malalties greus o cròniques. Es recomana als grups sensibles que evitin l'exposició prolongada.";
    } else {
      Aqitext = "ALERTA SANITÀRIA: Tots els grups de població poder patir greus problemes per a la salut i l'exposició prolongada a aquests nivells pot causar morts prematures.";
    }

    return Aqitext;
  }

  String getLevel(int AqiLevel) {
    //print("Selecting color for: ${AqiLevel}");

    String Aqitext = "BO";
    if (AqiLevel <= 50) {
      Aqitext = "BO";
    } else if (AqiLevel > 50 && AqiLevel <= 100) {
      Aqitext = "MODERAT";
    } else if (AqiLevel > 100 && AqiLevel <= 150) {
      Aqitext = "POBRE";
    } else if (AqiLevel > 150 && AqiLevel <= 200) {
      Aqitext = "INSALUBRE";
    } else if (AqiLevel > 200 && AqiLevel <= 300) {
      Aqitext = "SEVER";
    } else {
      Aqitext = "PERILLÓS";
    }

    return Aqitext;
  }
  String getMainPollutant(int AqiLevel, List<int> listAqilevels) {
    bool found = false;
    int position = 0;
    while (!found) {
      if (listAqilevels[position] == AqiLevel) {
        found = true;
      } else {
        position++;
      }
    }
    switch (position) {
      case 0:
        return "O3";
      case 1:
        return "PM 2.5";
      case 2:
        return "PM 10";
      case 3:
        return "CO";
      case 4:
        return "SO2";
      case 5:
        return "NO2";
      default:
        return "03";
    }
  }

  List<dynamic> colorUV(int UVLevel) {
    //print("Selecting color for: ${UVLevel}");

    Color colorSelected = Color(0xFF7D0023);
    String textSelected = "Nivell baix";
    if (UVLevel <= 2) {
      colorSelected = Colors.lightGreen.shade800;
      textSelected = "Nivell baix";
    } else if (UVLevel > 2 && UVLevel <= 5) {
      colorSelected = Colors.amber;
      textSelected = "Nivell mitjà";
    } else if (UVLevel > 5 && UVLevel <= 7) {
      colorSelected = Colors.orange.shade800;
      textSelected = "Nivell alt";
    } else if (UVLevel > 7 && UVLevel <= 10) {
      colorSelected = Colors.redAccent.shade700;
      textSelected = "Nivell molt alt";
    } else {
      colorSelected = Colors.pink.shade800;
      textSelected = "Nivell extrem";
    }
    return [colorSelected, textSelected];
  }



}