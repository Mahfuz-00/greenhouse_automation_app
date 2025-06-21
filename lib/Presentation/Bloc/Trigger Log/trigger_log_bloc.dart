import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Domain/Usecases/Trigger Log/get_trigger_logs.dart';
import '../../../Domain/Usecases/Trigger Log/sync_trigger_logs.dart';
import 'trigger_log_event.dart';
import 'trigger_log_state.dart';

class TriggerLogBloc extends Bloc<TriggerLogEvent, TriggerLogState> {
  final GetTriggerLogs getTriggerLogs;
  final SyncTriggerLogs syncTriggerLogs;

  TriggerLogBloc(this.getTriggerLogs, this.syncTriggerLogs) : super(TriggerLogInitial()) {
    on<GetTriggerLogsEvent>((event, emit) async {
      emit(TriggerLogLoading());
      try {
        final triggerLogs = await getTriggerLogs(event.greenhouseId, event.startTime, event.endTime);
        emit(TriggerLogLoaded(triggerLogs));
      } catch (e) {
        emit(TriggerLogError(e.toString()));
      }
    });

    on<SyncTriggerLogsEvent>((event, emit) async {
      emit(TriggerLogLoading());
      try {
        await syncTriggerLogs(event.greenhouseId);
        final triggerLogs = await getTriggerLogs(event.greenhouseId, event.startTime, event.endTime);
        emit(TriggerLogLoaded(triggerLogs));
      } catch (e) {
        emit(TriggerLogError(e.toString()));
      }
    });
  }
}