import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
              Text('Conexões: '),
              _handleConnectionsList(context),
              _handleSaveButton(context)
            ],
          ),
        ));
  }

  Widget _handleTextFields(BuildContext context) {
    return Column(
      children: [
        const TextField(
            decoration: InputDecoration(
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

  Widget _handleSaveButton(BuildContext context) {
    return Container(
        color: Colors.green,
        margin: EdgeInsets.all(10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: ElevatedButton(
            child: Text('SALVAR'),
            onPressed: () {
              //
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

  void changeButtonColour(int index, int icon) {
    setState(() {
      line = index;
      row = icon;
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
                    color:
                        index == line && row == 0 ? Colors.red : Colors.grey),
                IconButton(
                    onPressed: () {
                      changeButtonColour(index, 1);
                    },
                    icon: const Icon(Icons.check_circle),
                    color:
                        index == line && row == 1 ? Colors.green : Colors.grey),
                IconButton(
                    onPressed: () {
                      changeButtonColour(index, 2);
                    },
                    icon: const Icon(Icons.offline_bolt),
                    color:
                        index == line && row == 2 ? Colors.amber : Colors.grey),
              ]));
        },
      ),
    );
  }
}
