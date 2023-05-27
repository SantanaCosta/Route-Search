class Connection {
  String stationId = "";
  int type = 0;

  Connection({
    required this.stationId,
    required this.type,
  });

  Connection.fromMap(map) {
    stationId = map['station']['stringValue'];
    type = map['type']['intValue'];
  }

  toMap() {
    return {"station": stationId, "type": type};
  }
}
