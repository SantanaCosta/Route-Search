import 'package:flutter/material.dart';

import '../model/edge.dart';
import '../model/graph.dart';
import '../model/vertex.dart';
import 'graph_widget.dart';

class RoutesPage extends StatefulWidget {
  const RoutesPage({super.key});

  @override
  State<RoutesPage> createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {
  final vertex1 = Vertex(x: 0, y: 100);
  final vertex2 = Vertex(x: -80, y: 80);
  final vertex3 = Vertex(x: 90, y: 120);
  final vertex4 = Vertex(x: 185, y: 70);
  final vertex5 = Vertex(x: 100, y: 50);
  final vertex6 = Vertex(x: -50, y: 200);
  @override
  Widget build(BuildContext context) {
    final graph = Graph(vertices: [
      vertex1,
      vertex2,
      vertex3,
      vertex4,
      vertex5,
      vertex6,
    ], edges: [
      Edge(start: vertex1, end: vertex2),
      Edge(start: vertex1, end: vertex3),
      Edge(start: vertex1, end: vertex4),
      Edge(start: vertex1, end: vertex5),
      Edge(start: vertex1, end: vertex6),
      Edge(start: vertex2, end: vertex3),
      Edge(start: vertex2, end: vertex4),
      Edge(start: vertex2, end: vertex5),
      Edge(start: vertex2, end: vertex6),
      Edge(start: vertex3, end: vertex4),
      Edge(start: vertex3, end: vertex5),
      Edge(start: vertex3, end: vertex6),
      Edge(start: vertex4, end: vertex5),
      Edge(start: vertex4, end: vertex6),
      Edge(start: vertex5, end: vertex6),
    ]);

    return Stack(
      children: [
        _handleGraphWidget(graph),
        _handleFloatingActionButton(context)
      ],
    );
  }

  Widget _handleGraphWidget(Graph graph) {
    return Expanded(
      child: InteractiveViewer(
        constrained: false,
        child: GraphWidget(
          graph: graph,
          vertexColor: Colors.blue,
          vertexRadius: 10,
          edgeColor: Colors.black,
          edgeWidth: 2.0,
        ),
      ),
    );
  }

  Widget _handleFloatingActionButton(BuildContext context) {
    double alturaTela = MediaQuery.of(context).size.height;
    double larguraTela = MediaQuery.of(context).size.width;
    return Positioned(
      bottom: alturaTela * 0.1,
      right: larguraTela * 0.1,
      child: FloatingActionButton(
        onPressed: () {
          _handleBottomSheet(context);
        },
        child: const Icon(Icons.route_outlined),
      ),
    );
  }

  void _handleBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BottomSheet(
              enableDrag: false,
              onClosing: () {},
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      _handleTextFields(),
                      _handleSliders(),
                      _handleButtons()
                    ],
                  ),
                );
              });
        });
  }

  Widget _handleTextFields() {
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.all(2.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Inicio',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(2.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Destino',
            ),
          ),
        ),
      ],
    );
  }

  Widget _handleSliders() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Prioridade",
          style: TextStyle(fontSize: 20),
        ),
        const Text(
          "Menor Distancia",
          style: TextStyle(fontSize: 14),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Slider(
              value: 10,
              max: 100,
              divisions: 5,
              label: "sla",
              onChanged: (double value) {},
            ),
            Container(
              height: 20,
              width: 50,
              color: Colors.grey[300],
              child: const Center(child: Text("10")),
            )
          ],
        ),
        const Text(
          "Poucas paradas",
          style: TextStyle(fontSize: 14),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Slider(
              value: 10,
              max: 100,
              divisions: 5,
              label: "sla",
              onChanged: (double value) {},
            ),
            Container(
              height: 20,
              width: 50,
              color: Colors.grey[300],
              child: const Center(child: Text("10")),
            )
          ],
        ),
        const Text(
          "Rapidez",
          style: TextStyle(fontSize: 14),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Slider(
              value: 10,
              max: 100,
              divisions: 5,
              label: "sla",
              onChanged: (double value) {},
            ),
            Container(
              height: 20,
              width: 50,
              color: Colors.grey[300],
              child: const Center(child: Text("10")),
            )
          ],
        ),
      ],
    );
  }

  Widget _handleButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20)),
          onPressed: () {},
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20)),
          onPressed: () {},
          child: const Text('Okay'),
        ),
      ],
    );
  }
}
