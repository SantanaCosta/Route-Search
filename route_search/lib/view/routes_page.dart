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
  @override
  Widget build(BuildContext context) {
    final vertex1 = Vertex(x: 50, y: 50);
    final vertex2 = Vertex(x: 200, y: 200);
    final vertex3 = Vertex(x: 350, y: 50);
    final vertex4 = Vertex(x: 500, y: 200);
    final vertex5 = Vertex(x: 650, y: 50);
    final vertex6 = Vertex(x: 800, y: 200);

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: GraphWidget(
            graph: graph,
            vertexColor: Colors.blue,
            vertexRadius: 10,
            edgeColor: Colors.black,
            edgeWidth: 2.0,
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  _handleBottomSheet(context);
                },
                child: const Icon(Icons.route_outlined),
              ),
            ],
          ),
        )
      ],
    );
  }

  void _handleBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BottomSheet(
              onClosing: () {},
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
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
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Inicio',
          ),
        ),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Destino',
          ),
        ),
      ],
    );
  }

  Widget _handleSliders() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Prioridade"),
        Text("Menor Distancia"),
        Slider(
          value: 10,
          max: 100,
          divisions: 5,
          label: "sla",
          onChanged: (double value) {},
        ),
        Text("Poucas Paradas"),
        Slider(
          value: 10,
          max: 100,
          divisions: 5,
          label: "sla",
          onChanged: (double value) {},
        ),
        Text("Passagem Barata"),
        Slider(
          value: 10,
          max: 100,
          divisions: 5,
          label: "sla",
          onChanged: (double value) {},
        ),
      ],
    );
  }

  Widget _handleButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20)),
          onPressed: null,
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20)),
          onPressed: null,
          child: const Text('Okay'),
        ),
      ],
    );
  }
}
