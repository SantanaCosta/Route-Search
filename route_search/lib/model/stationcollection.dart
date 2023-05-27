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

  Station getStationAtIndex(int index) {
    Station station = stationList[index];
    return Station(
        name: station.name,
        coordX: station.coordX,
        coordY: station.coordY,
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
          connections: station.connections);
    } else {
      // Insert
      idList.add(id);
      stationList.add(Station(
          name: station.name,
          coordX: station.coordX,
          coordY: station.coordY,
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
        connections: station.connections));
  }
}
