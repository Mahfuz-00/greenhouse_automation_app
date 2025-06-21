import 'package:flutter/material.dart';
import '../Constants/app_colors.dart';
import '../Constants/app_values.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.text),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.text),
        bodyMedium: TextStyle(fontSize: 14, color: AppColors.text),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppValues.borderRadius)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppValues.borderRadius)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
          borderRadius: BorderRadius.circular(AppValues.borderRadius),
        ),
      ),
    );
  }
}