import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../Common/Constants/app_colors.dart';
import '../../Common/Constants/app_strings.dart';
import '../../Core/Widgets/custom_background.dart';
import '../../Core/Widgets/custom_button.dart';
import '../../Core/Widgets/custom_text_field.dart';
import '../../Domain/Entity/user.dart';
import '../Bloc/Auth/auth_bloc.dart';
import '../Bloc/Auth/auth_event.dart';
import '../Bloc/Auth/auth_state.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
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
                context.go('/login'); // Navigate to login on successful signup
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Push login prompt to bottom
              children: [
                Expanded(
                  child: Center( // Center main content vertically and horizontally
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // Vertically center
                        crossAxisAlignment: CrossAxisAlignment.center, // Horizontally center
                        children: [
                          const SizedBox(height: 16), // Add top spacing
                          const Text(
                            'Sign up',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Please sign up to proceed',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 32),
                          CustomTextField(
                            label: 'Name',
                            controller: _nameController,
                            borderColor: AppColors.primary,
                            prefixIcon: Icons.person, // Icon for Name
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: 'Email',
                            controller: _emailController,
                            borderColor: AppColors.primary,
                            prefixIcon: Icons.email, // Icon for Email
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: 'Phone Number',
                            controller: _phoneController,
                            borderColor: AppColors.primary,
                            isNumber: true, // Match phone input
                            prefixIcon: Icons.phone, // Icon for Phone
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
                            text: AppStrings.signup,
                            onPressed: () {
                              final user = User(
                                id: const Uuid().v4(),
                                name: _nameController.text,
                                email: _emailController.text,
                                phone1: _phoneController.text,
                                phone2: null, // No Phone Number 2
                                profilePicture: null,
                                isAdmin: false, // Default to false, handled server-side
                              );
                              context.read<AuthBloc>().add(
                                SignupEvent(user, _passwordController.text),
                              );
                            },
                          ),
                          const SizedBox(height: 16), // Add bottom spacing
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.go('/login'),
                      child: const Text(
                        'Login',
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