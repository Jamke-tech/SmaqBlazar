import 'dart:math';
import '../helpers/pollutants_limits.dart';
import 'data_model.dart';

class StationModel {
  String name;
  String IDStation;
  String Description;
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

  Limits limits = Limits();

  int getAQI() {
    if (lastAQI.isNotEmpty) {
      int AQI = lastAQI[0];

      for (int i = 1; i < lastAQI.length; i++) {
        if (AQI < lastAQI[i]) {
          AQI = lastAQI[i];
        }
      }
      return AQI;
    }
    return -1;
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
      while (i < lastData.length && DateTime.parse(lastData[i].CreationDate.replaceAll("/", "-")).day == DateTime.parse(lastData[0].CreationDate.replaceAll("/", "-")).day) {
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
      while (i < lastData.length && DateTime.parse(lastData[i].CreationDate.replaceAll("/", "-")).day == DateTime.parse(lastData[0].CreationDate.replaceAll("/", "-")).day) {
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

  void computeAQI(DateTime time) {
    List<double> CxAverage = getAverageCxFromData(
        time); // In order : 03 (8h) / PM25 (3h)  / PM10 (3h) / CO (8h) / SO2 (1h) / NO2 (1h)
    List<int> AQIFinal = []; // In order : 03 / PM25 / PM10 / CO / SO2 / NO2

    if (CxAverage.isNotEmpty) {
      //Computing AQI level from O3
      if (CxAverage[0] < 0.2) {
        List<double> limitsO38 = limits.getLimitsO38(CxAverage[0]);
        AQIFinal.add(computeAqiFromLimits(limitsO38, CxAverage[0]));
      } else {
        List<double> limitsO3 = limits.getLimitsO3(CxAverage[0]);
        AQIFinal.add(computeAqiFromLimits(limitsO3, CxAverage[0]));
      }

      //Computing AQI level from PM25
      List<double> limitsPM25 = limits.getLimitsPM25(CxAverage[1]);
      AQIFinal.add(computeAqiFromLimits(limitsPM25, CxAverage[1]));

      //Computing AQI level from PM10
      List<double> limitsPM10 = limits.getLimitsPM10(CxAverage[2]);
      AQIFinal.add(computeAqiFromLimits(limitsPM10, CxAverage[2]));

      //Computing AQI level from CO
      List<double> limitsCO = limits.getLimitsCO(CxAverage[3]);
      AQIFinal.add(computeAqiFromLimits(limitsCO, CxAverage[3]));

      //We need to multiply by 1000 as the computing of AQI is in ppb
      //Computing AQI level from SO2
      List<double> limitsSO2 = limits.getLimitsSO2(CxAverage[4] * 1000);
      AQIFinal.add(computeAqiFromLimits(limitsSO2, CxAverage[4] * 1000));

      //Computing AQI level from NO2
      List<double> limitsNO2 = limits.getLimitsNO2(CxAverage[5] * 1000);
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
      print("Substract date: ${time.toString()}");
      DateTime lastDataTime = time;
      //We have to do the average for 1h pollutants
      DateTime actualDataTime = lastDataTime;
      int values1H = 0;
      double sumO3 = 0;
      double sumSO2 = 0;
      double sumNO2 = 0;
      int vectorPosition = 0;
      int initialVectorPosition = 0;


      //first we have to find the vector position for the date selected which is going to be the first date = or lower than that the lastDataTime
      bool foundVectorDate = false;
      while(!foundVectorDate && initialVectorPosition < lastData.length - 1 ){
        if(DateTime.parse(
            lastData[initialVectorPosition].CreationDate.replaceAll("/", "-")).isBefore(lastDataTime) || lastData[initialVectorPosition].CreationDate.replaceAll("/", "-") == lastData.toString()  ){
          foundVectorDate=true;
        }else{
        initialVectorPosition++;}

      }
      print("Vector position selected : $initialVectorPosition and the vector  $vectorPosition");
      print("Initial counting data:${DateTime.parse(
          lastData[initialVectorPosition].CreationDate.replaceAll("/", "-"))} ");

      vectorPosition = initialVectorPosition;
      actualDataTime = DateTime.parse(
          lastData[initialVectorPosition].CreationDate.replaceAll("/", "-"));
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
      actualDataTime = DateTime.parse(
          lastData[initialVectorPosition].CreationDate.replaceAll("/", "-"));
      int values8H = 0;
      double sumO38 = 0;
      double sumCO = 0;

      vectorPosition = initialVectorPosition;

      while (lastDataTime.difference(actualDataTime).inHours < 8 &&
          vectorPosition < lastData.length - 1) {
        //Mentre la diferencia sigui menor a 1h ho afegim a la suma
        //print(vectorPosition);
        //print("Length vector:${lastData.length}");

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
      actualDataTime = DateTime.parse(
          lastData[initialVectorPosition].CreationDate.replaceAll("/", "-"));
      int values24H = 0;
      double sumPM25 = 0;
      double sumPM10 = 0;
      double sumSO224 = 0;

      vectorPosition = initialVectorPosition;

      while (lastDataTime.difference(actualDataTime).inHours < 24 &&
          vectorPosition < lastData.length - 1) {
        //Mentre la diferencia sigui menor a 1h ho afegim a la suma

        sumPM25 = sumPM25 + lastData[vectorPosition].PM25;
        sumPM10 = sumPM10 + lastData[vectorPosition].PM10;
        sumSO224 = sumSO224 + lastData[vectorPosition].CxSO2;

        //Next value
        actualDataTime = DateTime.parse(
            lastData[vectorPosition + 1].CreationDate.replaceAll("/", "-"));
        values24H++;
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

      listReturn.add((sumPM25 / values24H));
      listReturn.add((sumPM10 / values24H));
      listReturn.add((sumCO / values8H));

      double CxSO224 = (sumSO224 / values24H);
      print("SO2 24h : ${CxSO224*1000}");
      double CxSO2 = (sumSO2 / values1H);
      print("SO2 1h : ${CxSO2*1000}");

      if (CxSO2 * 1000 > 305) {
        listReturn.add(CxSO224);
      } else {
        listReturn.add(CxSO2);
      }

      listReturn.add((sumNO2 / values1H));

      return listReturn;
    } else if (lastData.length == 1) {
      return [];
    } else {
      return [];
    }
  }

  List<int> getAQIListFromCx(List<double> averageCxFromData) {
    // In order : 03 (8h or 3h) / PM25 (24h)  / PM10 (24h) / CO (8h) / SO2 (1h or 24h) / NO2 (1h)
    List<int> AQIFinal = []; // In order : 03 / PM25 / PM10 / CO / SO2 / NO2

    if (averageCxFromData.isNotEmpty) {
      //Computing AQI level from O3
      if (averageCxFromData[0] < 0.2) {
        List<double> limitsO38 = limits.getLimitsO38(averageCxFromData[0]);
        AQIFinal.add(computeAqiFromLimits(limitsO38, averageCxFromData[0]));
      } else {
        List<double> limitsO3 = limits.getLimitsO3(averageCxFromData[0]);
        AQIFinal.add(computeAqiFromLimits(limitsO3, averageCxFromData[0]));
      }

      //Computing AQI level from PM25
      List<double> limitsPM25 = limits.getLimitsPM25(averageCxFromData[1]);
      AQIFinal.add(computeAqiFromLimits(limitsPM25, averageCxFromData[1]));

      //Computing AQI level from PM10
      List<double> limitsPM10 = limits.getLimitsPM10(averageCxFromData[2]);
      AQIFinal.add(computeAqiFromLimits(limitsPM10, averageCxFromData[2]));

      //Computing AQI level from CO
      List<double> limitsCO = limits.getLimitsCO(averageCxFromData[3]);
      AQIFinal.add(computeAqiFromLimits(limitsCO, averageCxFromData[3]));

      //We need to multiply by 1000 as the computing of AQI is in ppb
      //Computing AQI level from SO2
      List<double> limitsSO2 = limits.getLimitsSO2(averageCxFromData[4] * 1000);
      AQIFinal.add(
          computeAqiFromLimits(limitsSO2, averageCxFromData[4] * 1000));

      //Computing AQI level from NO2
      List<double> limitsNO2 = limits.getLimitsNO2(averageCxFromData[5] * 1000);
      AQIFinal.add(
          computeAqiFromLimits(limitsNO2, averageCxFromData[5] * 1000));

      return AQIFinal;
    } else {
      return [];
    }
  }
}
