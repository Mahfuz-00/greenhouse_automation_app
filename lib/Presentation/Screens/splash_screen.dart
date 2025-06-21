import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../Common/Constants/app_colors.dart';
import '../../Common/Constants/app_strings.dart';
import '../../Core/Widgets/custom_background.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      context.go('/login');
    });

    return const CustomBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Text(
            AppStrings.appTitle,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
        ),
      ),
    );
  }
}