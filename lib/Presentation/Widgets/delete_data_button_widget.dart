import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Common/Constants/app_strings.dart';
import '../../Core/Widgets/custom_button.dart';
import '../Bloc/Greenhouse/greenhouse_bloc.dart';
import '../Bloc/Greenhouse/greenhouse_event.dart';


class DeleteDataButtonWidget extends StatelessWidget {
  const DeleteDataButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: AppStrings.deleteData,
      onPressed: () {
        context.read<GreenhouseBloc>().add(DeleteOldDataEvent());
      },
    );
  }
}