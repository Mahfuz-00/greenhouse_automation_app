import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Common/Constants/app_colors.dart';
import '../../../Common/Constants/app_values.dart';
import '../../../Core/Widgets/custom_background.dart';
import '../../../Core/Widgets/custom_button.dart';
import '../../Bloc/Greenhouse/greenhouse_bloc.dart';
import '../../Bloc/Greenhouse/greenhouse_event.dart';
import '../../Bloc/Greenhouse/greenhouse_state.dart';
import '../../Widgets/greenhouse_form_widget.dart';


class GreenhouseManagementScreen extends StatelessWidget {
  const GreenhouseManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(title: const Text('Greenhouse Management')),
        body: Padding(
          padding: const EdgeInsets.all(AppValues.padding),
          child: BlocBuilder<GreenhouseBloc, GreenhouseState>(
            builder: (context, state) {
              if (state is GreenhouseLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is GreenhouseLoaded) {
                return ListView.builder(
                  itemCount: state.greenhouses.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return CustomButton(
                        text: 'Add Greenhouse',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => GreenhouseFormWidget(
                              onSubmit: (greenhouse) {
                                context.read<GreenhouseBloc>().add(AddGreenhouseEvent(greenhouse));
                              },
                            ),
                          );
                        },
                      );
                    }
                    final greenhouse = state.greenhouses[index - 1];
                    return Card(
                      child: ListTile(
                        title: Text(greenhouse.location),
                        subtitle: Text('Size: ${greenhouse.size} sq ft'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => GreenhouseFormWidget(
                                    greenhouse: greenhouse,
                                    onSubmit: (updatedGreenhouse) {
                                      context.read<GreenhouseBloc>().add(EditGreenhouseEvent(updatedGreenhouse));
                                    },
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: AppColors.error),
                              onPressed: () {
                                context.read<GreenhouseBloc>().add(DeleteGreenhouseEvent(greenhouse.id));
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return const Text('Error loading greenhouses', style: TextStyle(color: AppColors.error));
            },
          ),
        ),
      ),
    );
  }
}