import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Common/Constants/app_colors.dart';
import '../../../Common/Constants/app_values.dart';
import '../../../Core/Widgets/custom_background.dart';
import '../../../Core/Widgets/custom_button.dart';
import '../../Bloc/Auth/auth_bloc.dart';
import '../../Bloc/Auth/auth_state.dart';
import '../../Bloc/Greenhouse/greenhouse_bloc.dart';
import '../../Bloc/Greenhouse/greenhouse_state.dart';
import '../../Bloc/Sensor Data/sensor_data_bloc.dart';
import '../../Bloc/Sensor Data/sensor_data_event.dart';
import '../../Bloc/Sensor Data/sensor_data_state.dart';
import '../../Bloc/Trigger Log/trigger_log_bloc.dart';
import '../../Bloc/Trigger Log/trigger_log_event.dart';
import '../../Bloc/Trigger Log/trigger_log_state.dart';
import '../../Widgets/report_graph_widget.dart';


class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  bool _showYearly = false;

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(title: const Text('Reports')),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            if (authState is AuthAuthenticated) {
              final greenhouse = context.read<GreenhouseBloc>().state is GreenhouseLoaded
                  ? (context.read<GreenhouseBloc>().state as GreenhouseLoaded)
                  .greenhouses
                  .firstWhere((g) => g.userId == authState.user.id)
                  : null;
              if (greenhouse == null) {
                return const Center(child: Text('No greenhouse assigned'));
              }
              final startTime = _showYearly
                  ? DateTime.now().subtract(const Duration(days: 365)).millisecondsSinceEpoch
                  : DateTime.now().subtract(const Duration(days: 30)).millisecondsSinceEpoch;
              final endTime = DateTime.now().millisecondsSinceEpoch;
              context.read<SensorDataBloc>().add(GetSensorDataEvent(greenhouse.id, startTime, endTime));
              context.read<TriggerLogBloc>().add(GetTriggerLogsEvent(greenhouse.id, startTime, endTime));
              return Padding(
                padding: const EdgeInsets.all(AppValues.padding),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomButton(
                        text: _showYearly ? 'Show 30 Days' : 'Show Yearly',
                        onPressed: () => setState(() => _showYearly = !_showYearly),
                      ),
                      const SizedBox(height: 16),
                      ReportGraphWidget(
                        title: 'Temperature',
                        data: (state) => state is SensorDataLoaded
                            ? state.sensorData.map((d) => FlSpot(d.timestamp.toDouble(), d.temperature)).toList()
                            : [],
                      ),
                      ReportGraphWidget(
                        title: 'Humidity',
                        data: (state) => state is SensorDataLoaded
                            ? state.sensorData.map((d) => FlSpot(d.timestamp.toDouble(), d.humidity)).toList()
                            : [],
                      ),
                      ReportGraphWidget(
                        title: 'Soil Moisture',
                        data: (state) => state is SensorDataLoaded
                            ? state.sensorData.map((d) => FlSpot(d.timestamp.toDouble(), d.soilMoisture)).toList()
                            : [],
                      ),
                      ReportGraphWidget(
                        title: 'Control Triggers',
                        data: (state) => state is TriggerLogLoaded
                            ? [
                          ...state.triggerLogs
                              .where((log) => log.isAuto)
                              .map((log) => FlSpot(log.timestamp.toDouble(), 1)),
                          ...state.triggerLogs
                              .where((log) => !log.isAuto)
                              .map((log) => FlSpot(log.timestamp.toDouble(), 0)),
                        ]
                            : [],
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}