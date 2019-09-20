import 'package:http/http.dart' show Client;
import '../models/agent_model.dart';

class ApiService {

  final String baseUrl = "http://157.245.44.245:8000/";
  Client client = Client();

  Future<List<Agent>> getProfiles() async {
    final response = await client.get("$baseUrl/api/users");
    if (response.statusCode == 200) {
      return agentFromJson(response.body);
    } else {
      return null;
    }
  }

}