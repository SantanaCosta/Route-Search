import 'connection.dart';

class Station {
  final String id;
  final String name;
  final double coordX;
  final double coordY;
  final List<Connection> connections;

  Station({
    required this.id,
    required this.name,
    required this.coordX,
    required this.coordY,
    required this.connections,
  });

  factory Station.fromMap(Map<String, dynamic> map) {
    final fields = map['fields'] as Map<String, dynamic>;
    return Station(
      id: map['id'],
      name: fields['name']['stringValue'],
      coordX: fields['coordX']['doubleValue'],
      coordY: fields['coordY']['doubleValue'],
      connections: (fields['connections']['arrayValue']['values'] as List)
          .map((e) => Connection.fromMap(e['mapValue']['fields']))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': {'stringValue': name},
      'coordX': {'doubleValue': coordX},
      'coordY': {'doubleValue': coordY},
      'connections': {
        'arrayValue': {
          'values': connections
              .map((e) => {
                    'mapValue': {'fields': e.toMap()}
                  })
              .toList(),
        },
      },
    };
  }
}
