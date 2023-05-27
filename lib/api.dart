import 'base_network.dart';

class ApiDataSource{
  static ApiDataSource instance = ApiDataSource();

  Future<List<dynamic>> loadMatches(){
    return BaseNetwork.getList("matches");
  }

  Future<Map<String, dynamic>> loadMatchDetails(String name){
    String nama = name;
    return BaseNetwork.get("matches/"+ nama);
  }
}