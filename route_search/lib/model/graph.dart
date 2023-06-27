import 'package:flutter/material.dart';
import 'package:route_search/model/station.dart';
import 'package:route_search/model/stationcollection.dart';

import 'edge.dart';
import 'vertex.dart';

class Graph {
  final List<Vertex> vertices;
  final List<Edge> edges;

  Graph({required this.vertices, required this.edges});

  Graph.empty()
      : vertices = [],
        edges = [];

  Graph clearGraph(Graph graph) {
    for (int i = 0; i < graph.vertices.length; i++) {
      graph.vertices[i].color = Colors.grey;
    }

    return graph;
  }

  int getIndexByLabel(String label) {
    for (int i = 0; i < vertices.length; i++) {
      if (vertices[i].label == label) {
        return i;
      }
    }

    return -1;
  }

  static Graph toGraph(StationCollection stationCollection) {
    Graph graph = Graph.empty();

    for (int i = 0; i < stationCollection.length(); i++) {
      Station station = stationCollection.stationList[i];
      Vertex stationVertex =
          Vertex(label: station.name, x: station.coordX, y: station.coordY);

      graph.vertices.add(stationVertex);

      for (int j = 0; j < station.connections.length; j++) {
        Station connectedStation =
            stationCollection.getStationOfId(station.connections[j].stationId)!;

        Color color = Colors.grey;
        if (station.line == connectedStation.line) color = Colors.indigo;

        graph.edges.add(Edge(
            start: stationVertex,
            end: Vertex(
                label: connectedStation.name,
                x: connectedStation.coordX,
                y: connectedStation.coordY),
            color: color,
            type: station.connections[j].type));
      }
    }

    return graph;
  }
}
