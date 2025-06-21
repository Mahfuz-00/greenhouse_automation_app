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
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: const Text(AppStrings.login)),
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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: Column(
              children: [
                CustomTextField(label: 'Email', controller: _emailController),
                const SizedBox(height: 16),
                CustomTextField(label: 'Password', controller: _passwordController),
                const SizedBox(height: 16),
                CustomButton(
                  text: AppStrings.login,
                  onPressed: () {
                    context.read<AuthBloc>().add(
                      LoginEvent(_emailController.text, _passwordController.text),
                    );
                  },
                ),
                TextButton(
                  onPressed: () => context.go('/signup'),
                  child: const Text('Sign Up', style: TextStyle(color: AppColors.primary)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}