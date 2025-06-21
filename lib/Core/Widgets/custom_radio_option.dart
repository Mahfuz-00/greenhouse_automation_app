import 'package:flutter/material.dart';

import '../../Common/Constants/app_colors.dart';

class CustomRadioOption<T> extends StatelessWidget {
  final String label;
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  const CustomRadioOption({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<T>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: AppColors.primary,
        ),
        Text(label, style: const TextStyle(fontFamily: 'Roboto', fontSize: 14)),
      ],
    );
  }
}