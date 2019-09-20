import 'dart:convert';

class Agent {
  int id;
  String name;
  String password;
  int tel;

  Agent({this.id = 0, this.name, this.password, this.tel});

  factory Agent.fromJson(Map<String, dynamic> map) {
    return Agent(
        id: map["id"], name: map["name"], password: map["password"], tel: map["tel"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "password": password, "tel": tel};
  }

  @override
  String toString() {
    return 'Agent{id: $id, name: $name, password: $password, tel: $tel}';
  }

}

List<Agent> agentFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Agent>.from(data.map((item) => Agent.fromJson(item)));
}

String agentToJson(Agent data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}