import 'package:flutter/material.dart';

import '../model/graph.dart';

class GraphPainter extends CustomPainter {
  final Graph graph;
  final double vertexRadius;
  final Color edgeColor;
  final double edgeWidth;

  GraphPainter(this.graph, this.vertexRadius, this.edgeColor, this.edgeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    for (final edge in graph.edges) {
      final start =
          Offset(edge.start.x + size.width / 2, size.height / 2 - edge.start.y);
      final end =
          Offset(edge.end.x + size.width / 2, size.height / 2 - edge.end.y);

      canvas.drawLine(
        start,
        end,
        Paint()
          ..color = edgeColor
          ..strokeWidth = edgeWidth,
      );
    }

    for (final vertex in graph.vertices) {
      final center =
          Offset(vertex.x + size.width / 2, size.height / 2 - vertex.y);

      canvas.drawCircle(
        center,
        vertexRadius,
        Paint()
          ..color = vertex.color
          ..strokeWidth = 1.0,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
