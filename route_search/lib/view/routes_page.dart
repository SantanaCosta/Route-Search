import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:route_search/model/a_star.dart';

import '../bloc/monitor.dart';
import '../model/edge.dart';
import '../model/graph.dart';
import '../model/stationcollection.dart';
import '../model/vertex.dart';
import '../provider/rest_provider.dart';
import 'graph_widget.dart';

class RoutesPage extends StatefulWidget {
  const RoutesPage({super.key});

  @override
  State<RoutesPage> createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {
  final vertex1 = Vertex(x: 150, y: 100);
  final vertex2 = Vertex(x: -80, y: 80);
  final vertex3 = Vertex(x: 90, y: 120);
  final vertex4 = Vertex(x: 185, y: 70);
  final vertex5 = Vertex(x: 100, y: 50);
  final vertex6 = Vertex(x: -50, y: 200);

  final _inicioTextEditingController = TextEditingController();
  final _destinoTextEditingController = TextEditingController();
  double _distanciaSliderValue = 0;
  double _tempoSliderValue = 0;
  double _linhasSliderValue = 0;
  final StreamController<double> _streamController = StreamController<double>();

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
    return InteractiveViewer(
      constrained: false,
      child: GraphWidget(
        graph: graph,
        vertexColor: Colors.blue,
        vertexRadius: 10,
        edgeColor: Colors.black,
        edgeWidth: 2.0,
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
                return Column(
                  children: [
                    _handleTextFields(),
                    _handleSliders(),
                    _handleButtons(context)
                  ],
                );
              });
        });
  }

  Widget _handleTextFields() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(2.0),
          child: TextField(
            controller: _inicioTextEditingController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Inicio',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(2.0),
          child: TextField(
            controller: _destinoTextEditingController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Destino',
            ),
          ),
        ),
      ],
    );
  }

  Widget _handleSliders() {
    final _distanciaValueNotifier =
        ValueNotifier<double>(_distanciaSliderValue);
    final _trocasLinhasValueNotifier =
        ValueNotifier<double>(_linhasSliderValue);
    final _tempoValueNotifier = ValueNotifier<double>(_tempoSliderValue);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Níveis de prioridade",
          style: TextStyle(fontSize: 20),
        ),
        const Text(
          "Menor Distância",
          style: TextStyle(fontSize: 14),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ValueListenableBuilder<double>(
              valueListenable: _distanciaValueNotifier,
              builder: (context, value, child) {
                return Slider(
                  value: value,
                  max: 100,
                  divisions: 5,
                  label: value.round().toString(),
                  onChanged: (double newValue) {
                    _distanciaValueNotifier.value = newValue;
                    _distanciaSliderValue = newValue;
                  },
                );
              },
            ),
            Container(
              height: 20,
              width: 50,
              color: Colors.grey[300],
              child: Center(
                child: ValueListenableBuilder<double>(
                  valueListenable: _distanciaValueNotifier,
                  builder: (context, value, child) {
                    return Text(value.round().toString());
                  },
                ),
              ),
            )
          ],
        ),
        const Text(
          "Poucas trocas de linha",
          style: TextStyle(fontSize: 14),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ValueListenableBuilder<double>(
              valueListenable: _trocasLinhasValueNotifier,
              builder: (context, value, child) {
                return Slider(
                  value: value,
                  max: 100,
                  divisions: 5,
                  label: value.round().toString(),
                  onChanged: (double newValue) {
                    _trocasLinhasValueNotifier.value = newValue;
                    _linhasSliderValue = newValue;
                  },
                );
              },
            ),
            Container(
              height: 20,
              width: 50,
              color: Colors.grey[300],
              child: Center(
                child: ValueListenableBuilder<double>(
                  valueListenable: _trocasLinhasValueNotifier,
                  builder: (context, value, child) {
                    return Text(value.round().toString());
                  },
                ),
              ),
            )
          ],
        ),
        const Text(
          "Menor tempo",
          style: TextStyle(fontSize: 14),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ValueListenableBuilder<double>(
              valueListenable: _tempoValueNotifier,
              builder: (context, value, child) {
                return Slider(
                  value: value,
                  max: 100,
                  divisions: 5,
                  label: value.round().toString(),
                  onChanged: (double newValue) {
                    _tempoValueNotifier.value = newValue;
                    _tempoSliderValue = newValue;
                  },
                );
              },
            ),
            Container(
              height: 20,
              width: 50,
              color: Colors.grey[300],
              child: Center(
                child: ValueListenableBuilder<double>(
                  valueListenable: _tempoValueNotifier,
                  builder: (context, value, child) {
                    return Text(value.round().toString());
                  },
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _handleButtons(BuildContext context) {
    return BlocBuilder<MonitorBloc, MonitorState>(builder: (context, state) {
      StationCollection stationCollection = state.stationCollection;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20)),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20)),
            onPressed: () {
              List<double> weight = [
                _distanciaSliderValue / 100.0,
                _linhasSliderValue / 100.0,
                _tempoSliderValue / 100.0
              ];
              AStar().search(
                  stationCollection,
                  _inicioTextEditingController.text,
                  _destinoTextEditingController.text,
                  weight,
                  120.0);

              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    });
  }
}
