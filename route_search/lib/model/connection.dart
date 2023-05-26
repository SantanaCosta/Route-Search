class Connection {
  final String station;
  final String type;

  Connection({
    required this.station,
    required this.type,
  });

  factory Connection.fromMap(Map<String, dynamic> map) {
    final station = map['station']['stringValue'];
    final type = map['type']['stringValue'];

    return Connection(
      station: station,
      type: type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mapValue': {
        'fields': {
          'station': {'stringValue': station},
          'type': {'stringValue': type},
        }
      }
    };
  }
}
