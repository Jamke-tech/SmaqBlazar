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
  //final String IpApi = '127.0.0.1:25000'; // per simualció web
  final String IpApi = '10.0.2.2:25000'; // per simulació de Android STUDIO
  //final String IpApi = '147.83.7.158:25000'; // per docker



}