import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Common/Constants/app_strings.dart';
import '../../Core/Widgets/custom_button.dart';
import '../Bloc/Control Items/control_item_bloc.dart';
import '../Bloc/Control Items/control_item_event.dart';
import '../Bloc/Greenhouse/greenhouse_bloc.dart';
import '../Bloc/Greenhouse/greenhouse_event.dart';
import '../Bloc/Sensor Data/sensor_data_bloc.dart';
import '../Bloc/Sensor Data/sensor_data_event.dart';
import '../Bloc/Trigger Log/trigger_log_bloc.dart';
import '../Bloc/Trigger Log/trigger_log_event.dart';


class SyncButtonWidget extends StatelessWidget {
  final String greenhouseId;

  const SyncButtonWidget({super.key, required this.greenhouseId});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: AppStrings.sync,
      onPressed: () {
        context.read<GreenhouseBloc>().add(SyncGreenhouseDataEvent(greenhouseId));
        context.read<SensorDataBloc>().add(SyncSensorDataEvent(greenhouseId,));
        context.read<ControlItemBloc>().add(GetControlItemsEvent(greenhouseId));
        context.read<TriggerLogBloc>().add(SyncTriggerLogsEvent(
          greenhouseId,
          DateTime.now().subtract(const Duration(days: 365)).millisecondsSinceEpoch,
          DateTime.now().millisecondsSinceEpoch,
        ));
      },
    );
  }
}