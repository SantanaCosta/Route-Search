import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_search/bloc/monitor.dart';
import 'package:route_search/model/stationcollection.dart';

import '../bloc/events.dart';
import '../bloc/manage_bloc.dart';

class StationsPage extends StatefulWidget {
  const StationsPage({super.key});

  @override
  State<StationsPage> createState() => _StationsPageState();
}

class _StationsPageState extends State<StationsPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      _handleListView(context),
      _handleFloatingActionButton(context)
    ]);
  }

  Widget _handleListView(BuildContext context) {
    return BlocBuilder<MonitorBloc, MonitorState>(builder: (context, state) {
      StationCollection stationCollection = state.stationCollection;
      return ListView.builder(
        itemCount: stationCollection.length(),
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(stationCollection.getStationAtIndex(index).name),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                IconButton(
                  onPressed: () {
                    print(stationCollection.length());
                    BlocProvider.of<ManageBloc>(context).add(UpdateRequest(
                      stationId: stationCollection.getIdAtIndex(index),
                      previousStation:
                          stationCollection.getStationAtIndex(index),
                    ));
                    Navigator.pushNamed(context, '/registro');
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    BlocProvider.of<ManageBloc>(context).add(DeleteEvent(
                      stationId: stationCollection.getIdAtIndex(index),
                    ));
                    stationCollection.deleteStationOfId(
                        stationCollection.getIdAtIndex(index));
                  },
                  icon: const Icon(Icons.delete),
                ),
              ]));
        },
      );
    });
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
