class Endpoints {
  //Hacemos un singleton para tener los datos simpre igual en todas las intancia de busqueda
  static final Endpoints _instance = Endpoints._internal();

  factory Endpoints(){
    return _instance;
  }
  Endpoints._internal() {
    // initialization logic
  }

  //Valores de las API points
  final String MongoDB = 'https://data.mongodb-api.com/app/data-ugjsw/endpoint/data/v1/action'; // per simulació de Android STUDIO
  final String APIKey = "MZpxcJNBp1UMJ8JGdnbH5lhR7sAt3CEiREyVlyfEjFkZBD6vuhE960x9TmQD5GHs";
  final String MongoDbCluster= "Cluster0";
  final String DataBaseName= "SmaqBlazar";
  final String MongoDbCollectionStations= "Stations";
  final String MongoDbCollectionDataCollected="DataCollected";

}