import 'package:route_search/model/station.dart';
import 'package:route_search/model/stationcollection.dart';

import 'connection.dart';

class AStarSearch {
  List<Station> search(StationCollection stationCollection, String originName,
      String destinationName, int weigth, double speed) {
    Map<Station, double> open = {};
    List<Station> closed = [];
    List<Station> route = [];

    Station? currentNode = stationCollection.getStationByName(originName);
    Station? destination = stationCollection.getStationByName(destinationName);
    if (currentNode == null || destination == null) return route;

    bool found = false;

    do {
      for (int i = 0; i < currentNode.getConnections.length; i++) {
        Station nodeConnection = stationCollection
            .getStationOfId(currentNode.getConnections[i].stationId)!;
        double distance = nodeConnection.distanceTo(destination);

        if (currentNode.getConnections[i].type == 1) speed *= 1.5;

        double travelTime = currentNode.distanceTo(nodeConnection) / speed;
      }
    } while (!found);

    return route;
  }
}
