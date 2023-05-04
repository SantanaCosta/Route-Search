import 'package:flutter/material.dart';

class StationsPage extends StatefulWidget {
  const StationsPage({super.key});

  @override
  State<StationsPage> createState() => _StationsPageState();
}

class _StationsPageState extends State<StationsPage> {
  final stations = [
    'Heloísa Marcela',
    'Jairo Messias',
    'Juca Ramos',
    'Leonardo Amarelo',
    'Zayon Rodrigues'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _handleListView(context),
      Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/registro');
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,
          )),
    ]);
  }

  deleteStation(int id) {
    setState(() {
      stations.remove(stations[id]);
    });
  }

  Widget _handleListView(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(stations[index]),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/registro');
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    deleteStation(index);
                  },
                  icon: const Icon(Icons.delete),
                ),
              ]));
        },
      ),
    );
  }
}
