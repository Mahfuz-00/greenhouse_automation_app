import 'package:flutter/material.dart';

import '../../Common/Constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isNumber;
  final int? maxLength;
  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.isNumber = false,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
      style: const TextStyle(fontFamily: 'Roboto', fontSize: 14),
    );
  }
}