import '../model/station.dart';

abstract class ManageState {}

class InsertState extends ManageState {}

class UpdateState extends ManageState {
  String stationId;
  Station previousStation;

  UpdateState({
    required this.stationId,
    required this.previousStation,
  });
}
