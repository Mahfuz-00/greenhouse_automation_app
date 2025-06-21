import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Domain/Usecases/Senson Data/get_sensor_data.dart';
import '../../../Domain/Usecases/Senson Data/sync_sensor_data.dart';
import 'sensor_data_event.dart';
import 'sensor_data_state.dart';

class SensorDataBloc extends Bloc<SensorDataEvent, SensorDataState> {
  final GetSensorData getSensorData;
  final SyncSensorData syncSensorData;

  SensorDataBloc(this.getSensorData, this.syncSensorData) : super(SensorDataInitial()) {
    on<GetSensorDataEvent>((event, emit) async {
      emit(SensorDataLoading());
      try {
        final sensorData = await getSensorData(event.greenhouseId, event.startTime, event.endTime);
        emit(SensorDataLoaded(sensorData));
      } catch (e) {
        emit(SensorDataError(e.toString()));
      }
    });

    on<SyncSensorDataEvent>((event, emit) async {
      emit(SensorDataLoading());
      try {
        await syncSensorData(event.greenhouseId);
        final sensorData = await getSensorData(
          event.greenhouseId,
          DateTime.now().subtract(const Duration(days: 365)).millisecondsSinceEpoch,
          DateTime.now().millisecondsSinceEpoch,
        );
        emit(SensorDataLoaded(sensorData));
      } catch (e) {
        emit(SensorDataError(e.toString()));
      }
    });
  }
}