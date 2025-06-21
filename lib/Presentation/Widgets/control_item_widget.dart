import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Common/Constants/app_colors.dart';
import '../../Common/Constants/app_strings.dart';
import '../../Core/Dependecy Injection/di.dart';
import '../../Core/Widgets/custom_radio_option.dart';
import '../../Domain/Entity/control_item.dart';
import '../Bloc/Control Items/control_item_bloc.dart';
import '../Bloc/Control Items/control_item_event.dart';


class ControlItemWidget extends StatelessWidget {
  final ControlItem controlItem;

  const ControlItemWidget({super.key, required this.controlItem});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ControlItemBloc>(),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryLight),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            const Icon(Icons.settings),
            const SizedBox(width: 8),
            Expanded(child: Text('${controlItem.name} (${controlItem.count})')),
            CustomRadioOption<bool>(
              label: AppStrings.on,
              value: true,
              groupValue: controlItem.isActive,
              onChanged: (value) {
                context.read<ControlItemBloc>().add(
                  UpdateControlItemEvent(controlItem.copyWith(isActive: value!)),
                );
              },
            ),
            CustomRadioOption<bool>(
              label: AppStrings.off,
              value: false,
              groupValue: controlItem.isActive,
              onChanged: (value) {
                context.read<ControlItemBloc>().add(
                  UpdateControlItemEvent(controlItem.copyWith(isActive: value!)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}