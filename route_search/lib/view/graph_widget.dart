import 'package:flutter/material.dart';
import '../model/graph.dart';
import 'graph_painter.dart';

class GraphWidget extends StatelessWidget {
  final Graph graph;
  final double vertexRadius;
  final double edgeWidth;

  const GraphWidget({
    super.key,
    required this.graph,
    this.vertexRadius = 8.0,
    this.edgeWidth = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double canvasSizeWidth = 540;
      double canvasSizeHeight = 540;
      return CustomPaint(
        size: Size(
            canvasSizeWidth, canvasSizeHeight), // Define o tamanho do canvas
        painter: GraphPainter(graph, vertexRadius, edgeWidth),
      );
    });
  }
}
