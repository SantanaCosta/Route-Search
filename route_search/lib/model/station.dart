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
    final connections = fields['connections']['arrayValue']['values'];

    // final List<Connection> connectionList = connections.map((connection) {
    //   return Connection.fromMap(connection['mapValue']['fields']);
    // }).toList();

    return Station(
      name: name,
      coordX: coordX.toDouble(),
      coordY: coordY.toDouble(),
      connections: [],
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
    };

    return {'fields': map};
  }
}
