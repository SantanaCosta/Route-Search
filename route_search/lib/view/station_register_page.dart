import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_search/provider/rest_provider.dart';
import 'package:provider/provider.dart';
import '../bloc/events.dart';
import '../bloc/manage_bloc.dart';
import '../bloc/monitor.dart';
import '../bloc/states.dart';
import '../model/connection.dart';
import '../model/station.dart';
import '../model/stationcollection.dart';

class StationRegisterPage extends StatefulWidget {
  const StationRegisterPage({super.key});

  @override
  State<StationRegisterPage> createState() => _StationRegisterPageState();
}

class _StationRegisterPageState extends State<StationRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Registro'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _handleTextFields(context),
              _handleDescription(context),
              _handleConnectionsList(context),
              _handleSaveButton(context)
            ],
          ),
        ));
  }

  String nameValue = "";
  String xValue = "";
  String yValue = "";

  Widget _handleTextFields(BuildContext context) {
    return BlocBuilder<ManageBloc, ManageState>(builder: (context, state) {
      return Column(
        children: [
          TextFormField(
              initialValue:
                  state is UpdateState ? state.previousStation.name : "",
              onChanged: (value) {
                nameValue = value;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome da estação',
              )),
          Row(
            children: [
              SizedBox(
                width: 75,
                child: TextFormField(
                    initialValue: state is UpdateState
                        ? state.previousStation.coordX.toString()
                        : "",
                    onChanged: (value) {
                      xValue = value;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'X',
                    )),
              ),
              SizedBox(height: 70, width: 10),
              SizedBox(
                width: 75,
                child: TextFormField(
                    initialValue: state is UpdateState
                        ? state.previousStation.coordY.toString()
                        : "",
                    onChanged: (value) {
                      yValue = value;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Y',
                    )),
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget _handleDescription(BuildContext context) {
    return Column(children: [
      const Text(
        'Conexões com outras estações',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 19,
        ),
      ),
      Row(children: [
        const Expanded(
            child: Text(
          'Estação',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        )),
        Expanded(
            child: Column(children: [
          Row(children: const [
            Icon(
              Icons.cancel,
              color: Colors.red,
            ),
            Text(' = Sem conexão.')
          ]),
          Row(children: const [
            Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            Text(' = Conexão comum.')
          ]),
          Row(children: const [
            Icon(
              Icons.offline_bolt,
              color: Colors.amber,
            ),
            Text(' = Conexão rápida.')
          ])
        ]))
      ])
    ]);
  }

  List<Connection> connections = [];

  List<Connection> _getConnections(int qty) {
    // Temporário
    List<Connection> connections = [
      Connection(
        station: 'A',
        type: 'slow',
      ),
      Connection(
        station: 'B',
        type: 'slow',
      ),
      Connection(
        station: 'C',
        type: 'fast',
      )
    ];

    return connections;
  }

  Widget _handleSaveButton(BuildContext context) {
    return Container(
        color: Colors.green,
        margin: EdgeInsets.all(10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: ElevatedButton(
            child: Text('SALVAR'),
            onPressed: () {
              print("Abaixo?");
              Station station = Station(
                name: nameValue,
                coordX: double.parse(xValue),
                coordY: double.parse(yValue),
                connections: connections,
              );
              print("Cima?");
              BlocProvider.of<ManageBloc>(context).add(
                SubmitEvent(station: station),
              );
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: Size(0, 50),
            ),
          ),
        ));
  }

  int line = -1;
  int row = -1;

  bool init = true;
  List<List<Color>> colours = [];

  void changeButtonColour(int index, int icon) {
    setState(() {
      line = index;
      row = icon;

      if (line != -1) {
        colours[line] = [Colors.grey, Colors.grey, Colors.grey];
      }

      switch (icon) {
        case 0:
          colours[index][0] = Colors.red;
          break;
        case 1:
          colours[index][1] = Colors.green;
          break;
        case 2:
          colours[index][2] = Colors.amber;
          break;
        default:
          colours[index][icon] = Colors.grey;
      }
    });
  }

  int count = 0;
  Widget _handleConnectionsList(BuildContext context) {
    return BlocBuilder<MonitorBloc, MonitorState>(builder: (context, state) {
      StationCollection stationCollection = state.stationCollection;
      if (init) {
        colours = List.generate(stationCollection.length(),
            (i) => [Colors.red, Colors.grey, Colors.grey]);
        count = stationCollection.length();
      }
      init = false;

      connections = _getConnections(stationCollection.length());

      return Expanded(
        child: ListView.builder(
          itemCount: count,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(stationCollection.getStationAtIndex(index).name),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  IconButton(
                      onPressed: () {
                        changeButtonColour(index, 0);
                      },
                      icon: const Icon(Icons.cancel),
                      color: colours[index][0]),
                  IconButton(
                      onPressed: () {
                        changeButtonColour(index, 1);
                      },
                      icon: const Icon(Icons.check_circle),
                      color: colours[index][1]),
                  IconButton(
                      onPressed: () {
                        changeButtonColour(index, 2);
                      },
                      icon: const Icon(Icons.offline_bolt),
                      color: colours[index][2]),
                ]));
          },
        ),
      );
    });
  }
}
