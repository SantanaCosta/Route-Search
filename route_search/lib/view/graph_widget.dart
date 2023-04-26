import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../model/graph.dart';
import 'graph_painter.dart';

class GraphWidget extends StatelessWidget {
  final Graph graph;
  final Color vertexColor;
  final double vertexRadius;
  final Color edgeColor;
  final double edgeWidth;

  const GraphWidget({
    super.key,
    required this.graph,
    this.vertexColor = Colors.black,
    this.vertexRadius = 8.0,
    this.edgeColor = Colors.black,
    this.edgeWidth = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double canvasSize = constraints.minWidth;
      return CustomPaint(
        size: Size(canvasSize, canvasSize), // Define o tamanho do canvas
        painter: GraphPainter(
          graph,
          vertexColor,
          vertexRadius,
          edgeColor,
          edgeWidth,
        ),
      );
    });
  }
}
