import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';

import 'data_model.dart';

class StationModel {
  String name;
  String IDStation;
  String Description;

  //String Picture;
  double lat;
  double long;

  List<DataStation> lastData;
  List<int> lastAQI;

  StationModel(
      {required this.name,
      required this.IDStation,
      required this.Description,
      required this.lat,
      required this.long,
      required this.lastData,
      required this.lastAQI});

  int getAQI() {
    if (lastAQI.isNotEmpty) {
      print(lastAQI);
      int AQI = lastAQI[0];

      for (int i = 1; i < lastAQI.length; i++) {
        if (AQI < lastAQI[i]) {
          AQI = lastAQI[i];
        }
      }
      print(AQI);
      return AQI;
    }
    return -1;
  }

  Color colorAQI(int AqiLevel) {
    print("Selecting color for: ${AqiLevel}");

    Color colorSelected = Color(0xFF7D0023);
    if (AqiLevel <= 50) {
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
    print("Selecting color for: ${AqiLevel}");

    String Aqitext = "No hi ha perill per la salut.";
    if (AqiLevel <= 50) {
      Aqitext = "No hi ha perill per la salut.";
    } else if (AqiLevel > 50 && AqiLevel <= 100) {
      Aqitext = "LLeu amenaça per a grups sensibles.";
    } else if (AqiLevel > 100 && AqiLevel <= 150) {
      Aqitext = "LLeugeres molèsties al respirar.";
    } else if (AqiLevel > 150 && AqiLevel <= 200) {
      Aqitext = "Greus problemes a grups sensibles.";
    } else if (AqiLevel > 200 && AqiLevel <= 300) {
      Aqitext = "Pot causar malalties cròniques o afectacions importants.";
    } else {
      Aqitext = "L'exposició prolongada pot causar morts prematures.";
    }

    return Aqitext;
  }

  String getLevel(int AqiLevel) {
    print("Selecting color for: ${AqiLevel}");

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

  List<dynamic> colorUV(int UVLevel) {
    print("Selecting color for: ${UVLevel}");

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

  void computeAQI(DateTime time) {
    List<double> CxAverage = getAverageCxFromData(
        time); // In order : 03 (8h) / PM25 (3h)  / PM10 (3h) / CO (8h) / SO2 (1h) / NO2 (1h)
    List<int> AQIFinal = []; // In order : 03 / PM25 / PM10 / CO / SO2 / NO2
    if (CxAverage.isNotEmpty) {
      //Computing AQI level from O3
      if (CxAverage[0] < 0.2) {
        List<double> limitsO38 = getLimitsO38(CxAverage[0]);
        AQIFinal.add(computeAqiFromLimits(limitsO38, CxAverage[0]));
      } else {
        List<double> limitsO3 = getLimitsO3(CxAverage[0]);
        AQIFinal.add(computeAqiFromLimits(limitsO3, CxAverage[0]));
      }

      //Computing AQI level from PM25
      List<double> limitsPM25 = getLimitsPM25(CxAverage[1]);
      AQIFinal.add(computeAqiFromLimits(limitsPM25, CxAverage[1]));

      //Computing AQI level from PM10
      List<double> limitsPM10 = getLimitsPM10(CxAverage[2]);
      AQIFinal.add(computeAqiFromLimits(limitsPM10, CxAverage[2]));

      //Computing AQI level from CO
      List<double> limitsCO = getLimitsCO(CxAverage[3]);
      AQIFinal.add(computeAqiFromLimits(limitsCO, CxAverage[3]));

      //We need to multiply by 1000 as the computing of AQI is in ppb
      //Computing AQI level from SO2
      List<double> limitsSO2 = getLimitsSO2(CxAverage[4] * 1000);
      AQIFinal.add(computeAqiFromLimits(limitsSO2, CxAverage[4] * 1000));

      //Computing AQI level from NO2
      List<double> limitsNO2 = getLimitsNO2(CxAverage[5] * 1000);
      AQIFinal.add(computeAqiFromLimits(limitsNO2, CxAverage[5] * 1000));

      print(AQIFinal);

      lastAQI = AQIFinal;
    } else {
      lastAQI = [];
    }
  }

  int computeAqiFromLimits(List<double> limits, double Cx) {
    int AQILimits = ((((limits[3] - limits[2]) / (limits[1] - limits[0])) *
                (Cx - limits[0])) +
            limits[2])
        .round();

    if (AQILimits > 500) {
      return 500;
    } else {
      return AQILimits;
    }
  }

  List<double> getAverageCxFromData(DateTime time) {
    if (lastData.isNotEmpty && lastData.length > 1) {
      print("ComputingCxAverage for $IDStation");
      /*DateTime lastDataTime =
          DateTime.parse(lastData[0].CreationDate.replaceAll("/", "-"));
*/
      DateTime lastDataTime = time;
      //We have to do the average for 1h pollutants
      DateTime actualDataTime = lastDataTime;
      int values1H = 0;
      double sumO3 = 0;
      double sumSO2 = 0;
      double sumNO2 = 0;
      int vectorPosition = 0;

      while (lastDataTime.difference(actualDataTime).inHours < 1 &&
          vectorPosition < lastData.length - 1) {
        //Mentre la diferencia sigui menor a 1h ho afegim a la suma

        sumO3 = sumO3 + lastData[vectorPosition].CxO3;
        sumSO2 = sumSO2 + lastData[vectorPosition].CxSO2;
        sumNO2 = sumNO2 + lastData[vectorPosition].CxNO2;

        //Next value

        actualDataTime = DateTime.parse(
            lastData[vectorPosition + 1].CreationDate.replaceAll("/", "-"));
        values1H++;
        vectorPosition++;
      }

      //We compute the 8h average pollutants
      actualDataTime = lastDataTime;
      int values8H = 0;
      double sumO38 = 0;
      double sumCO = 0;

      vectorPosition = 0;

      while (lastDataTime.difference(actualDataTime).inHours < 8 &&
          vectorPosition < lastData.length - 1) {
        //Mentre la diferencia sigui menor a 1h ho afegim a la suma
        print(vectorPosition);
        print("Length vector:${lastData.length}");

        sumO38 = sumO38 + lastData[vectorPosition].CxO3;
        sumCO = sumCO + lastData[vectorPosition].CxCO;

        //Next value
        actualDataTime = DateTime.parse(
            lastData[vectorPosition + 1].CreationDate.replaceAll("/", "-"));
        values8H++;
        vectorPosition++;
      }

      //We will use the NowCast aproximation where the PM are comuted with 3H average
      //We compute the 3h average pollutants
      actualDataTime = lastDataTime;
      int values3H = 0;
      double sumPM25 = 0;
      double sumPM10 = 0;

      vectorPosition = 0;

      while (lastDataTime.difference(actualDataTime).inHours < 3 &&
          vectorPosition < lastData.length - 1) {
        //Mentre la diferencia sigui menor a 1h ho afegim a la suma

        sumPM25 = sumPM25 + lastData[vectorPosition].PM25;
        sumPM10 = sumPM10 + lastData[vectorPosition].PM10;

        //Next value
        actualDataTime = DateTime.parse(
            lastData[vectorPosition + 1].CreationDate.replaceAll("/", "-"));
        values3H++;
        vectorPosition++;
      }

      List<double> listReturn = [];

      double CXO38 = (sumO38 / values8H);
      double CX03 = (sumO3 / values1H);
      if (CX03 > 0.2) {
        listReturn.add(CXO38);
      } else {
        listReturn.add(CX03);
      }
      listReturn.add((sumPM25 / values3H));
      listReturn.add((sumPM10 / values3H));
      listReturn.add((sumCO / values8H));
      listReturn.add((sumSO2 / values1H));
      listReturn.add((sumNO2 / values1H));

      return listReturn;
    } else if (lastData.length == 1) {
      return [];
    } else {
      return [];
    }
  }

  List<double> getLimitsPM25(double Cx) {
    List<double> limitsPM25 = [];
    if (Cx <= 12.0) {
      limitsPM25 = [0, 12.0, 0, 50];
    } else if (Cx > 12 && Cx <= 35.4) {
      limitsPM25 = [12, 35.4, 51, 100];
    } else if (Cx > 35.4 && Cx <= 55.4) {
      limitsPM25 = [35.4, 55.4, 101, 150];
    } else if (Cx > 55.4 && Cx <= 150.4) {
      limitsPM25 = [55.4, 150.4, 151, 200];
    } else if (Cx > 150.4 && Cx <= 250.4) {
      limitsPM25 = [150.4, 250.4, 201, 300];
    } else if (Cx > 250.4 && Cx <= 350.4) {
      limitsPM25 = [250.4, 350.4, 301, 400];
    } else {
      limitsPM25 = [350.4, 500.4, 401, 500];
    }
    return limitsPM25;
  }

  List<double> getLimitsO38(double Cx) {
    List<double> limitsO3 = [];
    if (Cx <= 0.054) {
      limitsO3 = [0, 0.054, 0, 50];
    } else if (Cx > 0.054 && Cx <= 0.07) {
      limitsO3 = [0.054, 0.07, 51, 100];
    } else if (Cx > 0.07 && Cx <= 0.085) {
      limitsO3 = [0.07, 0.085, 101, 150];
    } else if (Cx > 0.085 && Cx <= 0.105) {
      limitsO3 = [0.085, 0.105, 151, 200];
    } else {
      limitsO3 = [0.105, 0.2, 201, 300];
    }
    return limitsO3;
  }

  List<double> getLimitsO3(double Cx) {
    List<double> limitsO3 = [];
    if (Cx <= 0.404) {
      limitsO3 = [0.2, 0.404, 201, 300];
    } else if (Cx > 0.404 && Cx <= 0.504) {
      limitsO3 = [0.404, 0.504, 301, 400];
    } else {
      limitsO3 = [0.504, 0.604, 401, 500];
    }

    return limitsO3;
  }

  List<double> getLimitsPM10(double Cx) {
    List<double> limitsPM10 = [];
    if (Cx <= 54) {
      limitsPM10 = [0, 54, 0, 50];
    } else if (Cx > 54 && Cx <= 154) {
      limitsPM10 = [54, 154, 51, 100];
    } else if (Cx > 154 && Cx <= 254) {
      limitsPM10 = [154, 254, 101, 150];
    } else if (Cx > 254 && Cx <= 354) {
      limitsPM10 = [254, 354, 151, 200];
    } else if (Cx > 354 && Cx <= 424) {
      limitsPM10 = [354, 424, 201, 300];
    } else if (Cx > 424 && Cx <= 504) {
      limitsPM10 = [424, 504, 301, 400];
    } else {
      limitsPM10 = [505, 604, 401, 500];
    }
    return limitsPM10;
  }

  List<double> getLimitsCO(double Cx) {
    List<double> limitsPM10 = [];
    if (Cx <= 4.4) {
      limitsPM10 = [0, 4.4, 0, 50];
    } else if (Cx > 4.4 && Cx <= 9.4) {
      limitsPM10 = [4.4, 9.4, 51, 100];
    } else if (Cx > 9.4 && Cx <= 12.4) {
      limitsPM10 = [9.4, 12.4, 101, 150];
    } else if (Cx > 12.4 && Cx <= 15.4) {
      limitsPM10 = [12.4, 15.4, 151, 200];
    } else if (Cx > 15.4 && Cx <= 30.4) {
      limitsPM10 = [15.4, 30.4, 201, 300];
    } else if (Cx > 30.4 && Cx <= 40.4) {
      limitsPM10 = [30.4, 40.4, 301, 400];
    } else {
      limitsPM10 = [40.4, 50.4, 401, 500];
    }
    return limitsPM10;
  }

  List<double> getLimitsSO2(double Cx) {
    List<double> limitsSO2 = [];
    if (Cx <= 35) {
      limitsSO2 = [0, 35, 0, 50];
    } else if (Cx > 35 && Cx <= 75) {
      limitsSO2 = [35, 75, 51, 100];
    } else if (Cx > 75 && Cx <= 185) {
      limitsSO2 = [75, 185, 101, 150];
    } else if (Cx > 185 && Cx <= 304) {
      limitsSO2 = [185, 304, 151, 200];
    } else if (Cx > 304 && Cx <= 604) {
      limitsSO2 = [304, 604, 201, 300];
    } else if (Cx > 604 && Cx <= 804) {
      limitsSO2 = [604, 804, 301, 400];
    } else {
      limitsSO2 = [804, 1004, 401, 500];
    }
    return limitsSO2;
  }

  List<double> getLimitsNO2(double Cx) {
    List<double> limitsNO2 = [];
    if (Cx <= 35) {
      limitsNO2 = [0, 35, 0, 50];
    } else if (Cx > 35 && Cx <= 75) {
      limitsNO2 = [35, 75, 51, 100];
    } else if (Cx > 75 && Cx <= 185) {
      limitsNO2 = [75, 185, 101, 150];
    } else if (Cx > 185 && Cx <= 304) {
      limitsNO2 = [185, 304, 151, 200];
    } else if (Cx > 304 && Cx <= 604) {
      limitsNO2 = [304, 604, 201, 300];
    } else if (Cx > 604 && Cx <= 804) {
      limitsNO2 = [604, 804, 301, 400];
    } else {
      limitsNO2 = [804, 1004, 401, 500];
    }
    return limitsNO2;
  }

  List<int> getAQIListFromCx(List<double> averageCxFromData) {
    // In order : 03 (8h) / PM25 (3h)  / PM10 (3h) / CO (8h) / SO2 (1h) / NO2 (1h)
    List<int> AQIFinal = []; // In order : 03 / PM25 / PM10 / CO / SO2 / NO2

    if (averageCxFromData.isNotEmpty) {
      //Computing AQI level from O3
      if (averageCxFromData[0] < 0.2) {
        List<double> limitsO38 = getLimitsO38(averageCxFromData[0]);
        AQIFinal.add(computeAqiFromLimits(limitsO38, averageCxFromData[0]));
      } else {
        List<double> limitsO3 = getLimitsO3(averageCxFromData[0]);
        AQIFinal.add(computeAqiFromLimits(limitsO3, averageCxFromData[0]));
      }

      //Computing AQI level from PM25
      List<double> limitsPM25 = getLimitsPM25(averageCxFromData[1]);
      AQIFinal.add(computeAqiFromLimits(limitsPM25, averageCxFromData[1]));

      //Computing AQI level from PM10
      List<double> limitsPM10 = getLimitsPM10(averageCxFromData[2]);
      AQIFinal.add(computeAqiFromLimits(limitsPM10, averageCxFromData[2]));

      //Computing AQI level from CO
      List<double> limitsCO = getLimitsCO(averageCxFromData[3]);
      AQIFinal.add(computeAqiFromLimits(limitsCO, averageCxFromData[3]));

      //We need to multiply by 1000 as the computing of AQI is in ppb
      //Computing AQI level from SO2
      List<double> limitsSO2 = getLimitsSO2(averageCxFromData[4] * 1000);
      AQIFinal.add(
          computeAqiFromLimits(limitsSO2, averageCxFromData[4] * 1000));

      //Computing AQI level from NO2
      List<double> limitsNO2 = getLimitsNO2(averageCxFromData[5] * 1000);
      AQIFinal.add(
          computeAqiFromLimits(limitsNO2, averageCxFromData[5] * 1000));

      return AQIFinal;
    } else {
      return [];
    }
  }

  double computeDewPoint(double temp, double humidity) {
    double a = 17.27;
    double b = 237.7;

    double F = ((a * temp) / (b + temp)) + log((humidity / 100));
    double dewPoint = ((b * F) / (a - F));
    return dewPoint;
  }

  List<double> computeMaxAndMinFromData(String data) {
    int i = 0;
    double max;
    double min;
    if (data == "Temp") {
      max = lastData[0].Temperature;
      min = max;
      while (i < lastData.length) {
        if (lastData[i].Temperature > max) {
          max = lastData[i].Temperature;
        }
        if (lastData[i].Temperature < min) {
          min = lastData[i].Temperature;
        }
        i++;
      }
      return [min, max];
    } else {
      max = lastData[0].Humidity;
      min = max;
      while (i < lastData.length) {
        if (lastData[i].Humidity > max) {
          max = lastData[i].Humidity;
        }
        if (lastData[i].Humidity < min) {
          min = lastData[i].Humidity;
        }
        i++;
      }
      return [min, max];
    }
  }
}
