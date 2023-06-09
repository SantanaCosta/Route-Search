import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_search/model/a_star.dart';
import 'package:route_search/view/lists_page.dart';

import '../bloc/monitor.dart';
import '../model/edge.dart';
import '../model/graph.dart';
import '../model/station.dart';
import '../model/stationcollection.dart';
import '../model/vertex.dart';
import 'graph_widget.dart';

class RoutesPage extends StatefulWidget {
  const RoutesPage({super.key});

  @override
  State<RoutesPage> createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {
  final _inicioTextEditingController = TextEditingController();
  final _destinoTextEditingController = TextEditingController();
  double _distanciaSliderValue = 0;
  double _tempoSliderValue = 0;
  double _linhasSliderValue = 0;
  final StreamController<List> _lists = StreamController<List>();
  final StreamController<Graph> _graph = StreamController<Graph>();
  Graph oldValue = Graph.empty();

  @override
  Widget build(BuildContext context) {
    _graph.add(Graph.empty());

    return Stack(
      children: [_handleGraphWidget(), _handleFloatingActionButton(context)],
    );
  }

  Widget _handleGraphWidget() {
    return BlocBuilder<MonitorBloc, MonitorState>(builder: (context, state) {
      StationCollection stationCollection = state.stationCollection;
      _graph.add(toGraph(stationCollection));
      return InteractiveViewer(
        constrained: false,
        child: StreamBuilder<Graph>(
            stream: _graph.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                oldValue = snapshot.data as Graph;

                return GraphWidget(
                  graph: snapshot.data as Graph,
                  vertexRadius: 10,
                  edgeColor: Colors.black,
                  edgeWidth: 2.0,
                );
              } else {
                return Text('Erro: ${snapshot.error}');
              }
            }),
      );
    });
  }

  Widget _handleFloatingActionButton(BuildContext context) {
    double alturaTela = MediaQuery.of(context).size.height;
    double larguraTela = MediaQuery.of(context).size.width;
    return Positioned(
        bottom: alturaTela * 0.1,
        right: larguraTela * 0.1,
        child: StreamBuilder<List>(
            stream: _lists.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListsPage(data: snapshot.data!),
                        ),
                      ),
                      child: const Icon(Icons.format_list_numbered_rounded),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        _handleBottomSheet(context);
                      },
                      child: const Icon(Icons.route_outlined),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        _handleBottomSheet(context);
                      },
                      child: const Icon(Icons.route_outlined),
                    ),
                  ],
                );
              }
            }));
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
              Navigator.of(context).pop();
              var result = AStar().search(
                  stationCollection,
                  _inicioTextEditingController.text,
                  _destinoTextEditingController.text,
                  weight,
                  35.0,
                  _graph,
                  oldValue);
              _lists.add(result);
            },
            child: const Text('OK'),
          ),
        ],
      );
    });
  }

  Graph toGraph(StationCollection stationCollection) {
    Graph graph = Graph.empty();

    for (int i = 0; i < stationCollection.length(); i++) {
      Station station = stationCollection.stationList[i];
      Vertex stationVertex =
          Vertex(label: station.name, x: station.coordX, y: station.coordY);

      graph.vertices.add(stationVertex);

      for (int j = 0; j < station.connections.length; j++) {
        Station connectedStation =
            stationCollection.getStationOfId(station.connections[j].stationId)!;

        graph.edges.add(Edge(
            start: stationVertex,
            end: Vertex(
                label: connectedStation.name,
                x: connectedStation.coordX,
                y: connectedStation.coordY)));
      }
    }

    return graph;
  }
}
