import 'dart:ui';

import 'vertex.dart';

class Edge {
  final Vertex start;
  final Vertex end;
  final Color color;
  final int type;

  Edge(
      {required this.start,
      required this.end,
      required this.color,
      required this.type});
}
