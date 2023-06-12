import 'dart:async';

import '../model/station.dart';

abstract class ManageEvent {}

class SubmitEvent extends ManageEvent {
  Station station;
  String? stationId;
  Completer? completer;
  SubmitEvent({required this.station, this.stationId, this.completer});
}

class DeleteEvent extends ManageEvent {
  String stationId;
  DeleteEvent({required this.stationId});
}

class UpdateRequest extends ManageEvent {
  String stationId;
  Station previousStation;

  UpdateRequest({
    required this.stationId,
    required this.previousStation,
  });
}

class UpdateCancel extends ManageEvent {}

class InsertEvent extends ManageEvent {}
