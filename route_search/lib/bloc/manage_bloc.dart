import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_search/bloc/states.dart';
import '../model/station.dart';
import '../provider/rest_provider.dart';
import 'events.dart';

class ManageBloc extends Bloc<ManageEvent, ManageState> {
  ManageBloc() : super(InsertState()) {
    on<SubmitEvent>(submitEvent);
    on<UpdateRequest>(updateRequest);
    on<UpdateCancel>(updateCancel);
    on<DeleteEvent>(deleteEvent);
    on<InsertEvent>(insertEvent);
  }

  insertEvent(InsertEvent event, Emitter emit) {
    emit(InsertState());
  }

  updateRequest(UpdateRequest event, Emitter emit) {
    emit(UpdateState(
      stationId: event.stationId,
      previousStation: event.previousStation,
    ));
  }

  updateCancel(UpdateCancel event, Emitter emit) {
    emit(InsertState());
  }

  deleteEvent(DeleteEvent event, Emitter emit) {
    RestDataProvider.helper.deleteStation(event.stationId);
  }

  submitEvent(SubmitEvent event, Emitter emit) {
    if (state is InsertState) {
      RestDataProvider.helper.createStation(event.station);
    } else if (state is UpdateState) {
      RestDataProvider.helper.updateStation(
        (state as UpdateState).stationId,
        event.station,
      );
      emit(InsertState());
    }
  }
}