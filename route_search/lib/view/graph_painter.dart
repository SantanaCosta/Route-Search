import 'package:flutter/material.dart';

import '../model/graph.dart';

class GraphPainter extends CustomPainter {
  final Graph graph;
  final Color vertexColor;
  final double vertexRadius;
  final Color edgeColor;
  final double edgeWidth;

  GraphPainter(this.graph, this.vertexColor, this.vertexRadius, this.edgeColor,
      this.edgeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    for (final edge in graph.edges) {
      final start = Offset(edge.start.x, edge.start.y);
      final end = Offset(edge.end.x, edge.end.y);

      canvas.drawLine(
        start,
        end,
        Paint()
          ..color = edgeColor
          ..strokeWidth = edgeWidth,
      );
    }

    for (final vertex in graph.vertices) {
      final center = Offset(vertex.x, vertex.y);

      canvas.drawCircle(
        center,
        vertexRadius,
        Paint()
          ..color = vertexColor
          ..strokeWidth = 1.0,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
