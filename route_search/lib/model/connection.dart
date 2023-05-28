class Connection {
  String stationId = "";
  int type = 0;

  Connection({
    required this.stationId,
    required this.type,
  });

  Connection.fromMap(map) {
    stationId = map['stationId'];
    type = map['type'];
  }

  toMap() {
    return {"stationId": stationId, "type": type};
  }
}
