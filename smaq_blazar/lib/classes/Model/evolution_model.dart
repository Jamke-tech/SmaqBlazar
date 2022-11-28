class EvolutionData{

  List<int> AQILevels;

  List<double> pollutantsAverage;
  int generalAQI;

  EvolutionData({required this.AQILevels, required this.pollutantsAverage, required this.generalAQI});

  int getAQI() {
    if (AQILevels.isNotEmpty) {
      int AQI = AQILevels[0];

      for (int i = 1; i < AQILevels.length; i++) {
        if (AQI < AQILevels[i]) {
          AQI = AQILevels[i];
        }
      }
      return AQI;
    }
    return -1;
  }



}