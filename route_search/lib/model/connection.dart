class Connection {
  final String station;
  final String type;

  Connection({
    required this.station,
    required this.type,
  });

  factory Connection.fromMap(Map<String, dynamic> map) {
    return Connection(
      station: map['station']['stringValue'],
      type: map['type']['stringValue'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'station': {'stringValue': station},
      'type': {'stringValue': type},
    };
  }
}
