import 'dart:async';

import 'package:flutter/material.dart';
import 'package:route_search/model/graph.dart';
import 'package:route_search/model/station.dart';
import 'package:route_search/model/stationcollection.dart';

class AStar {
  List search(
      StationCollection stationCollection,
      String originName,
      String destinationName,
      List<double> weigth,
      double speed,
      StreamController<Graph> graph,
      Graph graphValue) {
    // Listas para visualização
    List<List<Station>> openList = [];
    List<List<Station>> closedList = [];

    List results = [];

    List<Station> openNodes = [];
    List<Station> closed = [];
    Map<Station, Station?> previousStation = {};
    Map<Station, double> accumCost = {};
    List<Station> route = [];

    Station? currentNode = stationCollection.getStationByName(originName);
    Station? destination = stationCollection.getStationByName(destinationName);

    graph.add(graphValue.clearGraph(graphValue));

    if (currentNode == null || destination == null) return route;

    // Ajustando pesos
    double totalWeigth = weigth[0] + weigth[1] + weigth[2];
    if (totalWeigth > 0) {
      weigth[0] /= totalWeigth;
      weigth[1] /= totalWeigth;
      weigth[2] /= totalWeigth;
    }

    bool found = false;
    graph.add(graphValue);

    closed.add(currentNode);
    previousStation[currentNode] = null;
    accumCost[currentNode] = 0;
    do {
      // Descobrindo conexões do nó atual
      for (int i = 0; i < currentNode!.getConnections.length; i++) {
        Station nodeConnection = stationCollection
            .getStationOfId(currentNode.getConnections[i].stationId)!;

        if (!closed.contains(nodeConnection)) {
          double distanceToDestination = nodeConnection.distanceTo(destination);
          double distanceToConn = currentNode.distanceTo(nodeConnection);

          if (currentNode.getConnections[i].type == 1) speed *= 1.5;
          double travelTime = currentNode.distanceTo(nodeConnection) / speed;

          double lineChange = 0.0;
          if (currentNode.line != nodeConnection.line) {
            lineChange = (distanceToConn + travelTime) / 2.0;
          }

          // Função de avaliação da conexão i
          double evaluation = accumCost[currentNode]! +
              (weigth[0] * distanceToDestination) +
              (weigth[1] * lineChange) +
              (weigth[2] * travelTime);

          // Armazenando avaliação da conexão i
          accumCost[nodeConnection] = evaluation;

          // Definindo melhor estação anterior da conexão i
          if (!previousStation.containsKey(nodeConnection) ||
              accumCost[previousStation[nodeConnection]]! < evaluation) {
            previousStation[nodeConnection] = currentNode;
          }

          // Adicionando conexão i na lista de abertos
          if (!openNodes.contains(nodeConnection)) {
            openNodes.add(nodeConnection);
          }

          // Ordenando lista de abertos conforme avaliações
          if (openNodes.length > 1) {
            openNodes.sort((a, b) => (accumCost[a]!.compareTo(accumCost[b]!)));
          }
        }
      }
      if (!closed.contains(currentNode)) {
        closed.add(currentNode);
        openNodes.remove(currentNode);
      }
      if (openNodes.isEmpty) return [];

      // Atualizando lista de abertos e fechados para fins de visualização
      openList.add(openNodes.toList());
      closedList.add(closed.toList());

      // TEMPORÁRIO
      print("---FECHADOS ABAIXO---");
      List<Station> lastElement = closedList.last;
      for (Station station in lastElement) {
        print(station.name);
      }
      print("---ABERTOS ABAIXO---");
      lastElement = openList.last;
      for (Station station in lastElement) {
        print(station.name);
      }

      // Definindo nó atual como o melhor da lista de abertos
      currentNode = openNodes[0];

      // Atualizando cor do nó a ser expandido
      int indexToUpdate = -1;
      for (int i = 0; i < graphValue.vertices.length; i++) {
        if (graphValue.vertices[i].x == currentNode.coordX &&
            graphValue.vertices[i].y == currentNode.coordY) {
          indexToUpdate = i;
          break;
        }
      }

      graphValue.vertices[indexToUpdate].color = Colors.red;

      // Se nó atual for o destino, então busca acaba
      if (currentNode == destination) {
        found = true;
        closed.add(currentNode);
        openNodes.remove(currentNode);
        openList.add(openNodes.toList());
        closedList.add(closed.toList());
      }
    } while (!found);

    // Descobrindo melhor caminho de forma reversa
    print("---CAMINHO FINAL REVERSO---");
    Station? backtrackNode = destination;
    while (backtrackNode != null) {
      print(backtrackNode.name);
      route.add(backtrackNode);
      backtrackNode = previousStation[backtrackNode];
    }
    route = route.reversed.toList();

    // Alterando cor dos nós do melhor caminho
    int indexToUpdateFinal = -1;
    for (int i = 0; i < route.length; i++) {
      for (int j = 0; i < graphValue.vertices.length; j++) {
        if (graphValue.vertices[j].x == route[i].coordX &&
            graphValue.vertices[j].y == route[i].coordY) {
          indexToUpdateFinal = j;
          break;
        }
      }
      graphValue.vertices[indexToUpdateFinal].color = Colors.green;
    }

    graph.add(graphValue);

    results.add(openList);
    results.add(closedList);

    return results;
  }
}
