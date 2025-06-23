import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../Common/Constants/app_colors.dart';
import '../../../Common/Constants/app_strings.dart';
import '../../../Common/Constants/app_values.dart';
import '../../../Core/Widgets/custom_background.dart';
import '../../../Core/Widgets/custom_button.dart';
import '../../../Core/Widgets/custom_radio_option.dart';
import '../../Bloc/Auth/auth_bloc.dart';
import '../../Bloc/Auth/auth_event.dart';
import '../../Bloc/Auth/auth_state.dart';
import '../../Bloc/Control Items/control_item_bloc.dart';
import '../../Bloc/Control Items/control_item_event.dart';
import '../../Bloc/Control Items/control_item_state.dart';
import '../../Bloc/Greenhouse/greenhouse_bloc.dart';
import '../../Bloc/Greenhouse/greenhouse_state.dart';
import '../../Bloc/Sensor Data/sensor_data_bloc.dart';
import '../../Bloc/Sensor Data/sensor_data_event.dart';
import '../../Bloc/Sensor Data/sensor_data_state.dart';
import '../../Widgets/control_item_widget.dart';
import '../../Widgets/delete_data_button_widget.dart';
import '../../Widgets/sync_button_widget.dart';



class UserDashboardScreen extends StatelessWidget {
  const UserDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text(AppStrings.appTitle),
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () => context.go('/user_dashboard/profile'),
            ),
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthInitial) {
                  context.go('/login');
                }
              },
              child: IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () => context.read<AuthBloc>().add(LogoutEvent()),
              ),
            ),
          ],
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            if (authState is AuthAuthenticated) {
              return BlocBuilder<GreenhouseBloc, GreenhouseState>(
                builder: (context, greenhouseState) {
                  if (greenhouseState is GreenhouseLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (greenhouseState is GreenhouseLoaded) {
                    final userGreenhouse = greenhouseState.greenhouses
                        .firstWhere((g) => g.userId == authState.user.id);
                    if (userGreenhouse == null) {
                      return const Center(child: Text(AppStrings.noGreenhouse));
                    }
                    context.read<SensorDataBloc>().add(GetSensorDataEvent(
                      userGreenhouse.id,
                      DateTime.now().subtract(const Duration(days: 30)).millisecondsSinceEpoch,
                      DateTime.now().millisecondsSinceEpoch,
                    ));
                    context.read<ControlItemBloc>().add(GetControlItemsEvent(userGreenhouse.id));
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(AppValues.padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Location: ${userGreenhouse.location}'),
                          Text('Size: ${userGreenhouse.size} sq ft'),
                          Text('Last Updated: ${DateTime.fromMillisecondsSinceEpoch(userGreenhouse.lastUpdated)}'),
                          const SizedBox(height: 16),
                          BlocBuilder<SensorDataBloc, SensorDataState>(
                            builder: (context, sensorState) {
                              if (sensorState is SensorDataLoaded && sensorState.sensorData.isNotEmpty) {
                                final latest = sensorState.sensorData.last;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Temperature: ${latest.temperature} °C'),
                                    Text('Humidity: ${latest.humidity}%'),
                                    Text('Soil Moisture: ${latest.soilMoisture}%'),
                                  ],
                                );
                              }
                              return const Text('No sensor data available');
                            },
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            AppStrings.controlSystem,
                            style: TextStyle(fontSize: AppValues.controlItemFontSize, fontWeight: FontWeight.bold),
                          ),
                          BlocBuilder<ControlItemBloc, ControlItemState>(
                            builder: (context, controlState) {
                              if (controlState is ControlItemLoaded) {
                                final isAuto = controlState.controlItems.every((item) => item.isAuto);
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        CustomRadioOption<bool>(
                                          label: AppStrings.auto,
                                          value: true,
                                          groupValue: isAuto,
                                          onChanged: (value) {
                                            for (var item in controlState.controlItems) {
                                              context.read<ControlItemBloc>().add(
                                                UpdateControlItemEvent(item.copyWith(isAuto: value!)),
                                              );
                                            }
                                          },
                                        ),
                                        CustomRadioOption<bool>(
                                          label: AppStrings.manual,
                                          value: false,
                                          groupValue: isAuto,
                                          onChanged: (value) {
                                            for (var item in controlState.controlItems) {
                                              context.read<ControlItemBloc>().add(
                                                UpdateControlItemEvent(item.copyWith(isAuto: value!)),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    GridView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 3,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                      ),
                                      itemCount: controlState.controlItems.length,
                                      itemBuilder: (context, index) {
                                        return ControlItemWidget(controlItem: controlState.controlItems[index]);
                                      },
                                    ),
                                  ],
                                );
                              }
                              return const Text('No control items available');
                            },
                          ),
                          const SizedBox(height: 16),
                          CustomButton(
                            text: AppStrings.report,
                            onPressed: () => context.go('/user_dashboard/report'),
                          ),
                          const SizedBox(height: 16),
                          SyncButtonWidget(greenhouseId: userGreenhouse.id),
                          const SizedBox(height: 16),
                          DeleteDataButtonWidget(),
                        ],
                      ),
                    );
                  }
                  return const Text('Error loading greenhouse', style: TextStyle(color: AppColors.error));
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}