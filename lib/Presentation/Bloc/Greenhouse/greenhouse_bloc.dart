import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Domain/Usecases/Greenhouse/add_greenhouse.dart';
import '../../../Domain/Usecases/Greenhouse/delete_greenhouse.dart';
import '../../../Domain/Usecases/Greenhouse/delete_old_data.dart';
import '../../../Domain/Usecases/Greenhouse/edit_greenhouse.dart';
import '../../../Domain/Usecases/Greenhouse/get_greenhouses.dart';
import '../../../Domain/Usecases/Greenhouse/sync_greenhouse_data.dart';
import 'greenhouse_event.dart';
import 'greenhouse_state.dart';

class GreenhouseBloc extends Bloc<GreenhouseEvent, GreenhouseState> {
  final AddGreenhouse addGreenhouse;
  final EditGreenhouse editGreenhouse;
  final DeleteGreenhouse deleteGreenhouse;
  final GetGreenhouses getGreenhouses;
  final SyncGreenhouseData syncGreenhouseData;
  final DeleteOldData deleteOldData;

  GreenhouseBloc(
      this.addGreenhouse,
      this.editGreenhouse,
      this.deleteGreenhouse,
      this.getGreenhouses,
      this.syncGreenhouseData,
      this.deleteOldData,
      ) : super(GreenhouseInitial()) {
    on<AddGreenhouseEvent>((event, emit) async {
      emit(GreenhouseLoading());
      try {
        await addGreenhouse(event.greenhouse);
        final greenhouses = await getGreenhouses(event.greenhouse.userId);
        emit(GreenhouseLoaded(greenhouses));
      } catch (e) {
        emit(GreenhouseError(e.toString()));
      }
    });

    on<EditGreenhouseEvent>((event, emit) async {
      emit(GreenhouseLoading());
      try {
        await editGreenhouse(event.greenhouse);
        final greenhouses = await getGreenhouses(event.greenhouse.userId);
        emit(GreenhouseLoaded(greenhouses));
      } catch (e) {
        emit(GreenhouseError(e.toString()));
      }
    });

    on<DeleteGreenhouseEvent>((event, emit) async {
      emit(GreenhouseLoading());
      try {
        await deleteGreenhouse(event.id);
        final greenhouses = await getGreenhouses(null);
        emit(GreenhouseLoaded(greenhouses));
      } catch (e) {
        emit(GreenhouseError(e.toString()));
      }
    });

    on<GetGreenhousesEvent>((event, emit) async {
      emit(GreenhouseLoading());
      try {
        final greenhouses = await getGreenhouses(event.userId);
        emit(GreenhouseLoaded(greenhouses));
      } catch (e) {
        emit(GreenhouseError(e.toString()));
      }
    });

    on<SyncGreenhouseDataEvent>((event, emit) async {
      emit(GreenhouseLoading());
      try {
        await syncGreenhouseData(event.greenhouseId);
        final greenhouses = await getGreenhouses(null);
        emit(GreenhouseLoaded(greenhouses));
      } catch (e) {
        emit(GreenhouseError(e.toString()));
      }
    });

    on<DeleteOldDataEvent>((event, emit) async {
      emit(GreenhouseLoading());
      try {
        await deleteOldData();
        emit(GreenhouseLoaded(await getGreenhouses(null)));
      } catch (e) {
        emit(GreenhouseError(e.toString()));
      }
    });
  }
}