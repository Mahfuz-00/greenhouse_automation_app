import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../Common/Constants/app_colors.dart';
import '../../Common/Constants/app_strings.dart';
import '../../Core/Widgets/custom_background.dart';
import '../../Core/Widgets/custom_button.dart';
import '../../Core/Widgets/custom_text_field.dart';
import '../Bloc/Auth/auth_bloc.dart';
import '../Bloc/Auth/auth_event.dart';
import '../Bloc/Auth/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        backgroundColor: AppColors.background, // Set background to AppColors.background
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthAuthenticated) {
                if (state.user.isAdmin) {
                  context.go('/admin_dashboard');
                } else {
                  context.go('/user_dashboard');
                }
              } else if (state is AuthError) {
                context.go('/admin_dashboard');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Push prompt to bottom
              children: [
                Expanded(
                  child: Center( // Keep main content centered
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Vertically center
                      crossAxisAlignment: CrossAxisAlignment.center, // Horizontally center
                      children: [
                        const Text(
                          'Log in',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Please login to your account',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 32),
                        CustomTextField(
                          label: 'Email',
                          controller: _emailController,
                          borderColor: AppColors.primary,
                          prefixIcon: Icons.email, // Icon for Email
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          label: 'Password',
                          controller: _passwordController,
                          borderColor: AppColors.primary,
                          prefixIcon: Icons.lock, // Icon for Password
                          isPassword: true, // Enable password obscurity toggle
                        ),
                        const SizedBox(height: 16),
                        CustomButton(
                          text: AppStrings.login,
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              LoginEvent(_emailController.text, _passwordController.text),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have account? ",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.go('/signup'),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}