import 'edge.dart';
import 'vertex.dart';

class Graph {
  final List<Vertex> vertices;
  final List<Edge> edges;

  Graph({required this.vertices, required this.edges});

  Graph.empty()
      : vertices = [],
        edges = [];
}
