import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/events.dart';
import '../bloc/manage_bloc.dart';
import '../model/station.dart';

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

  final nameController = TextEditingController();

  Widget _handleTextFields(BuildContext context) {
    return Column(
      children: [
        TextField(
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nome da estação',
            )),
        Row(
          children: const [
            SizedBox(
              width: 75,
              child: TextField(
                  decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'X',
              )),
            ),
            SizedBox(height: 70, width: 10),
            SizedBox(
              width: 75,
              child: TextField(
                  decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Y',
              )),
            ),
          ],
        ),
      ],
    );
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

  Widget _handleSaveButton(BuildContext context) {
    return Container(
        color: Colors.green,
        margin: EdgeInsets.all(10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: ElevatedButton(
            child: Text('SALVAR'),
            onPressed: () {
              Station station = Station.fromMap({
                "id": nameController.text,
                "fields": {
                  "name": {"stringValue": nameController.text}
                }
              });
              BlocProvider.of<ManageBloc>(context).add(
                SubmitEvent(station: station),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: Size(0, 50),
            ),
          ),
        ));
  }

  final stations = [
    'Heloísa Marcela',
    'Jairo Messias',
    'Juca Ramos',
    'Leonardo Amarelo',
    'Zayon Rodrigues'
  ];

  int line = -1;
  int row = -1;

  List<List<Color>> colours =
      List.generate(5, (index) => [Colors.red, Colors.grey, Colors.grey]);

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

  Widget _handleConnectionsList(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(stations[index]),
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
  }
}
