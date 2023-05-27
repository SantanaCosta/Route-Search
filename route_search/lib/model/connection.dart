class Connection {
  String station = "";
  String type = "";

  Connection({
    required this.station,
    required this.type,
  });

  Connection.fromMap(map) {
    station = map['station']['stringValue'];
    type = map['type']['stringValue'];
  }

  toMap() {
    return {"station": station, "type": type};
  }
}
