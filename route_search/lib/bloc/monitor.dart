import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_search/model/station.dart';
import 'package:route_search/model/stationcollection.dart';

class MonitorBloc extends Bloc<MonitorEvent, MonitorState> {
  StationCollection stationCollection = StationCollection();
  DatabaseReference _databaseRef;

  MonitorBloc()
      : _databaseRef = FirebaseDatabase.instance.ref(),
        super(MonitorState(
          stationCollection: StationCollection(),
        )) {
    _databaseRef.onValue.listen((event) {
      final data = event.snapshot.value;

      if (data != null && data is Map) {
        data.forEach((key, value) {
          Map<String, dynamic> convertedMap = value.cast<String, dynamic>();
          stationCollection.updateOrInsertStationOfId(
              key, Station.fromMap(convertedMap));
        });
      }

      stationCollection.sortByName();
      add(UpdateList());
    });
    on<UpdateList>((event, Emitter emit) {
      emit(MonitorState(stationCollection: stationCollection));
    });
  }
}

abstract class MonitorEvent {}

class UpdateList extends MonitorEvent {}

class AskNewList extends MonitorEvent {}

class MonitorState {
  StationCollection stationCollection;
  MonitorState({required this.stationCollection});
}
