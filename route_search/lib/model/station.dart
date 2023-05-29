import 'connection.dart';
import 'dart:math';

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

  List<Connection> get getConnections => connections;

  double distanceTo(Station destination) {
    double dx = destination.coordX - coordX;
    double dy = destination.coordY - coordY;

    return sqrt(dx * dx + dy * dy);
  }

  void updateConnById(String stationId, int type) {
    bool found = false;

    for (int i = 0; i < connections.length; i++) {
      if (connections[i].stationId == stationId) {
        found = true;
        switch (type) {
          case -1:
            connections.removeAt(i);
            break;
          case 0:
            connections[i].type = 0;
            break;
          case 1:
            connections[i].type = 1;
            break;
          default:
        }
        break;
      }
    }

    if (!found && type != -1) {
      connections.add(Connection(stationId: stationId, type: type));
    }
  }

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
