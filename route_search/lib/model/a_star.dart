import 'dart:async';

import 'package:flutter/material.dart';
import 'package:route_search/model/graph.dart';
import 'package:route_search/model/station.dart';
import 'package:route_search/model/stationcollection.dart';
import 'package:route_search/model/vertex.dart';

class AStar {
  List<Station> search(
      StationCollection stationCollection,
      String originName,
      String destinationName,
      List<double> weigth,
      double speed,
      StreamController<Graph> graph) {
    List<Station> openNodes = [];
    List<Station> closed = [];
    Map<Station, Station?> previousStation = {};
    Map<Station, double> accumCost = {};
    List<Station> route = [];

    Station? currentNode = stationCollection.getStationByName(originName);
    Station? destination = stationCollection.getStationByName(destinationName);
    if (currentNode == null || destination == null) return route;

    bool found = false;

    closed.add(currentNode);
    previousStation[currentNode] = null;
    accumCost[currentNode] = 0;
    do {
      for (int i = 0; i < currentNode!.getConnections.length; i++) {
        Station nodeConnection = stationCollection
            .getStationOfId(currentNode.getConnections[i].stationId)!;

        if (!closed.contains(nodeConnection)) {
          double totalWeigth = weigth[0] + weigth[1] + weigth[2];

          if (totalWeigth > 0) {
            weigth[0] /= totalWeigth;
            weigth[1] /= totalWeigth;
            weigth[2] /= totalWeigth;
          }

          double distance = nodeConnection.distanceTo(destination);

          if (currentNode.getConnections[i].type == 1) speed *= 1.5;
          double travelTime = currentNode.distanceTo(nodeConnection) / speed;

          double lineChangePenalty = 1.0;
          if (currentNode.line != nodeConnection.line) {
            lineChangePenalty += weigth[1];
          }

          // DIMINUIR DISPARIDADE ENTRE DISTANCE E TRAVELTIME
          double evaluation = accumCost[currentNode]! +
              (lineChangePenalty *
                  (1.0 + ((weigth[0] * distance) + (weigth[2] * travelTime))));

          accumCost[nodeConnection] = evaluation;

          if (!previousStation.containsKey(nodeConnection) ||
              accumCost[previousStation[nodeConnection]]! < evaluation) {
            previousStation[nodeConnection] = currentNode;
          }

          openNodes.add(nodeConnection);
          print("Expandiu(" + currentNode.name + "): " + nodeConnection.name);

          if (openNodes.length > 1) {
            openNodes.sort((a, b) => (accumCost[a]!.compareTo(accumCost[b]!)));
          }
          List<Station> temp = openNodes;
          temp.remove(currentNode);
        }
      }
      if (!closed.contains(currentNode)) {
        openNodes.remove(currentNode);
        closed.add(currentNode);
      }
      if (openNodes.isEmpty) return [];

      currentNode = openNodes[0];

      graph.stream.listen((value) {
        int indexToUpdate = -1;
        for (int i = 0; i < value.vertices.length; i++) {
          if (value.vertices[i].x == currentNode?.coordX &&
              value.vertices[i].y == currentNode?.coordY) {
            indexToUpdate = i;
            break;
          }
        }

        value.vertices[indexToUpdate].color = Colors.red;

        graph.add(value);
      });

      print("Foi para " + currentNode.name);

      if (currentNode == destination) found = true;
    } while (!found);

    print("----------------------");
    for (Station station in route) {
      print(station.name);
    }

    accumCost.forEach((key, value) {
      print(key.name + ": " + value.toString());
    });

    Station? backtrackNode = destination;
    while (backtrackNode != null) {
      print(backtrackNode.name);
      route.add(backtrackNode);
      backtrackNode = previousStation[backtrackNode];
    }
    route = route.reversed.toList();

    return route;
  }
}
