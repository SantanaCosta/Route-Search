import 'connection.dart';

class Station {
  final String name;
  final double coordX;
  final double coordY;
  final List<Connection> connections;

  Station({
    required this.name,
    required this.coordX,
    required this.coordY,
    required this.connections,
  });

  factory Station.fromMap(Map<String, dynamic> map) {
    //print(map);
    final fields = map['fields'];
    final name = fields['name']['stringValue'];
    final coordX = fields['coordX']['doubleValue'];
    final coordY = fields['coordY']['doubleValue'];

    var connections = [];
    List<Connection> connectionList = [];

    try {
      connections = fields['connections']['arrayValue']['values'];

      if (connections.isNotEmpty) {
        connectionList = connections.map((connection) {
          return Connection.fromMap(connection);
        }).toList();
      }
    } catch (error) {}

    return Station(
      name: name,
      coordX: coordX.toDouble(),
      coordY: coordY.toDouble(),
      connections: connectionList,
    );
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
