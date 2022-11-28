class Limits {

  //Class for getting the limits for AQI computing for all pollutants
  List<double> getLimitsPM25(double Cx) {
    //limits in ug/m3

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
  List<double> getLimitsPM10(double Cx) {
    //limits in ug/m3

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

  List<double> getLimitsO38(double Cx) {
    //limits in ppm

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
    //limits in ppm

    List<double> limitsO3 = [];
    if(Cx<=0.164){
      limitsO3 = [0.125, 0.164, 101, 150];
    }
    else if ( Cx >0.164 && Cx <= 0.204) {
      limitsO3 = [0.164, 0.204, 151, 200];
    }
    else if ( Cx >0.204 && Cx <= 0.404) {
      limitsO3 = [0.2, 0.404, 201, 300];
    } else if (Cx > 0.404 && Cx <= 0.504) {
      limitsO3 = [0.404, 0.504, 301, 400];
    } else {
      limitsO3 = [0.504, 0.604, 401, 500];
    }

    return limitsO3;
  }



  List<double> getLimitsCO(double Cx) {
    //limits in ppm

    List<double> limitsCO = [];
    if (Cx <= 4.4) {
      limitsCO = [0, 4.4, 0, 50];
    } else if (Cx > 4.4 && Cx <= 9.4) {
      limitsCO = [4.4, 9.4, 51, 100];
    } else if (Cx > 9.4 && Cx <= 12.4) {
      limitsCO = [9.4, 12.4, 101, 150];
    } else if (Cx > 12.4 && Cx <= 15.4) {
      limitsCO = [12.4, 15.4, 151, 200];
    } else if (Cx > 15.4 && Cx <= 30.4) {
      limitsCO = [15.4, 30.4, 201, 300];
    } else if (Cx > 30.4 && Cx <= 40.4) {
      limitsCO = [30.4, 40.4, 301, 400];
    } else {
      limitsCO = [40.4, 50.4, 401, 500];
    }
    return limitsCO;
  }

  List<double> getLimitsSO2(double Cx) {
    //limits in ppb

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
    //limits in ppb

    List<double> limitsNO2 = [];
    if (Cx <= 53) {
      limitsNO2 = [0, 53, 0, 50];
    } else if (Cx > 53 && Cx <= 100) {
      limitsNO2 = [53, 100, 51, 100];
    } else if (Cx > 100 && Cx <= 360) {
      limitsNO2 = [100, 360, 101, 150];
    } else if (Cx > 360 && Cx <= 649) {
      limitsNO2 = [360, 649, 151, 200];
    } else if (Cx > 649 && Cx <= 1249) {
      limitsNO2 = [649, 1249, 201, 300];
    } else if (Cx > 1249 && Cx <= 1649) {
      limitsNO2 = [1249, 1649, 301, 400];
    } else {
      limitsNO2 = [1650, 2049, 401, 500];
    }
    return limitsNO2;
  }






}