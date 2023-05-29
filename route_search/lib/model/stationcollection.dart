import 'station.dart';

class StationCollection {
  List<String> idList = [];
  List<Station> stationList = [];

  stationCollection() {
    idList = [];
    stationList = [];
  }

  int length() {
    return idList.length;
  }

  double getDistance(String originId, Station destination) {
    Station origin = getStationOfId(originId)!;

    return origin.distanceTo(destination);
  }

  String getStationIdByName(String name) {
    for (int i = 0; i < stationList.length; i++) {
      //print("name $name == stationList[$i].name " + stationList[i].name + "?");
      if (stationList[i].name == name) return idList[i];
    }
    return "";
  }

  Station? getStationByName(String name) {
    for (int i = 0; i < stationList.length; i++) {
      //print("name $name == stationList[$i].name " + stationList[i].name + "?");
      if (stationList[i].name == name) return stationList[i];
    }
    return null;
  }

  Station? getStationOfId(String stationId) {
    for (int i = 0; i < stationList.length; i++) {
      if (idList[i] == stationId) return stationList[i];
    }
    return null;
  }

  Station getStationAtIndex(int index) {
    Station station = stationList[index];
    return Station(
        name: station.name,
        coordX: station.coordX,
        coordY: station.coordY,
        line: station.line,
        connections: station.connections);
  }

  String getIdAtIndex(int index) {
    return idList[index];
  }

  int getIndexOfId(String id) {
    return idList.indexOf(id);
  }

  updateOrInsertStationOfId(String id, Station station) {
    int index = getIndexOfId(id);
    if (index != -1) {
      // Update
      stationList[index] = Station(
          name: station.name,
          coordX: station.coordX,
          coordY: station.coordY,
          line: station.line,
          connections: station.connections);
    } else {
      // Insert
      idList.add(id);
      stationList.add(Station(
          name: station.name,
          coordX: station.coordX,
          coordY: station.coordY,
          line: station.line,
          connections: station.connections));
    }
  }

  updateStationOfId(String id, Station station) {
    int index = getIndexOfId(id);
    if (index != -1) {
      stationList[index] = Station(
          name: station.name,
          coordX: station.coordX,
          coordY: station.coordY,
          line: station.line,
          connections: station.connections);
    }
  }

  deleteStationOfId(String id) {
    int index = getIndexOfId(id);
    if (index != -1) {
      stationList.removeAt(index);
      idList.removeAt(index);
    }
  }

  insertStationOfId(String id, Station station) {
    idList.add(id);
    stationList.add(Station(
        name: station.name,
        coordX: station.coordX,
        coordY: station.coordY,
        line: station.line,
        connections: station.connections));
  }
}
