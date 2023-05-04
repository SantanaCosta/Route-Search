import 'package:flutter/material.dart';
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
      double canvasSizeWidth = 1080;
      double canvasSizeHeight = 2400;
      return CustomPaint(
        size: Size(
            canvasSizeWidth, canvasSizeHeight), // Define o tamanho do canvas
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
