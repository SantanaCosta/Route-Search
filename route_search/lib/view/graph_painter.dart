import 'package:flutter/material.dart';

import '../model/graph.dart';

class GraphPainter extends CustomPainter {
  final Graph graph;
  final double vertexRadius;
  final double edgeWidth;

  GraphPainter(this.graph, this.vertexRadius, this.edgeWidth);

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
            ..color = edge.color
            ..strokeWidth = edgeWidth);

      if (edge.type == 0) {
        canvas.drawLine(
            start,
            end,
            Paint()
              ..color = Colors.white
              ..strokeWidth = edgeWidth / 3.0);
      }
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

      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: vertex.label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      textPainter.paint(
        canvas,
        center - Offset(textPainter.width / 2, textPainter.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
