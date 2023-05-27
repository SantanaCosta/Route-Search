import 'connection.dart';

class Station {
  String name = "";
  double coordX = 0;
  double coordY = 0;
  List<Connection> connections = [];

  Station({
    required this.name,
    required this.coordX,
    required this.coordY,
    required this.connections,
  });

  /*factory Station.fromMap(Map<String, dynamic> map) {
    final fields = map['fields'];
    final name = fields['name']['stringValue'];
    final coordX = fields['coordX']['doubleValue'];
    final coordY = fields['coordY']['doubleValue'];
    final connections = fields['connections']['arrayValue']['values'];

    final List<Connection> connectionList = connections.map((connection) {
      return Connection.fromMap(connection['mapValue']['fields']);
    }).toList();

    return Station(
      name: name,
      coordX: coordX,
      coordY: coordY,
      connections: connectionList,
    );
  }

  Map<String, dynamic> toMap() {
    final map = {
      'name': {'stringValue': name},
      'coordX': {'doubleValue': coordX},
      'coordY': {'doubleValue': coordY},
      'connections': {
        'arrayValue': {
          'values': connections.map((connection) => connection.toMap()).toList()
        }
      }
    };*/

  Station.fromMap(map) {
    name = map["name"];
    coordX = map["coordX"];
    coordY = map["coordY"];
    connections = map["connections"];
  }

  toMap() {
    return {
      'name': {'stringValue': name},
      'coordX': {'doubleValue': coordX},
      'coordY': {'doubleValue': coordY},
      'connections': {
        'arrayValue': {
          'values': connections.map((connection) => connection.toMap()).toList()
        }
      }
    };
  }
}
