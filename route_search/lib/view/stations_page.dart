import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:route_search/bloc/auth.dart';
import 'package:route_search/bloc/monitor.dart';
import 'package:route_search/model/stationcollection.dart';

import '../bloc/events.dart';
import '../bloc/manage_bloc.dart';
import '../controler/navigationprovider.dart';
import '../model/connection.dart';
import '../model/station.dart';

class StationsPage extends StatefulWidget {
  const StationsPage({super.key});

  @override
  State<StationsPage> createState() => _StationsPageState();
}

class _StationsPageState extends State<StationsPage> {
  final bloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    final navigationProvider =
        Provider.of<NavigationProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: const Icon(Icons.logout_outlined),
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(Logout());
                  navigationProvider.updateCurrentIndex(1, context);
                }),
          ],
          title: const Text(
            "Estações",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(children: [
          _handleListView(context),
          _handleFloatingActionButton(context)
        ]));
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
                    String deletedStationId =
                        stationCollection.getIdAtIndex(index);
                    List<Connection> deletedConns =
                        stationCollection.getStationAtIndex(index).connections;
                    for (Connection conn in deletedConns) {
                      Station changedStation =
                          stationCollection.getStationOfId(conn.stationId)!;

                      BlocProvider.of<ManageBloc>(context).add(UpdateRequest(
                        stationId: conn.stationId,
                        previousStation: changedStation,
                      ));

                      changedStation.updateConnById(deletedStationId, -1);

                      BlocProvider.of<ManageBloc>(context).add(
                        SubmitEvent(station: changedStation),
                      );
                    }

                    BlocProvider.of<ManageBloc>(context).add(DeleteEvent(
                      stationId: deletedStationId,
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
          onPressed: () {
            BlocProvider.of<ManageBloc>(context).add(InsertEvent());
            Navigator.pushNamed(context, '/registro');
          },
          child: const Icon(Icons.add),
        ));
  }
}
