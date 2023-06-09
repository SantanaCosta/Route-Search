import 'package:flutter/material.dart';

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
      graph.vertices[i].color = Colors.blue;
    }

    return graph;
  }
}
