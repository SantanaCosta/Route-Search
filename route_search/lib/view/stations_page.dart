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
    return Stack(children: [
      _handleListView(context),
      _handleFloatingActionButton(context)
    ]);
  }

  deleteStation(int id) {
    setState(() {
      stations.remove(stations[id]);
    });
  }

  Widget _handleListView(BuildContext context) {
    return ListView.builder(
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
    );
  }

  Widget _handleFloatingActionButton(BuildContext context) {
    double alturaTela = MediaQuery.of(context).size.height;
    double larguraTela = MediaQuery.of(context).size.width;
    return Positioned(
        bottom: alturaTela * 0.1,
        right: larguraTela * 0.1,
        child: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.pushNamed(context, '/registro');
          },
        ));
  }
}
