import 'package:flutter/material.dart';

import '../../Common/Constants/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool isNumber;
  final int? maxLength;
  final Color? borderColor;
  final IconData? prefixIcon; // Added prefixIcon parameter
  final bool isPassword; // Added isPassword parameter

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.isNumber = false,
    this.maxLength,
    this.borderColor,
    this.prefixIcon,
    this.isPassword = false,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true; // Track password visibility

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.isNumber ? TextInputType.number : TextInputType.text,
      maxLength: widget.maxLength,
      obscureText: widget.isPassword && _obscureText, // Toggle obscurity for password
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon, color: AppColors.primary) : null, // Add prefix icon
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: AppColors.primary,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText; // Toggle visibility
            });
          },
        )
            : null, // Add suffix icon for password toggle
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: widget.borderColor ?? Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: widget.borderColor ?? Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
      style: const TextStyle(fontFamily: 'Roboto', fontSize: 14),
    );
  }
}