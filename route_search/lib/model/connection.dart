class Connection {
  String stationName = "";
  int type = 0;

  Connection({
    required this.stationName,
    required this.type,
  });

  Connection.fromMap(map) {
    stationName = map['stationName'];
    type = map['type'];
  }

  toMap() {
    return {"stationName": stationName, "type": type};
  }
}
