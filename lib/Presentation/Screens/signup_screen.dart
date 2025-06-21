import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

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
  final _phone1Controller = TextEditingController();
  final _phone2Controller = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isAdmin = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phone1Controller.dispose();
    _phone2Controller.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: const Text(AppStrings.signup)),
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextField(label: 'Name', controller: _nameController),
                  const SizedBox(height: 16),
                  CustomTextField(label: 'Email', controller: _emailController),
                  const SizedBox(height: 16),
                  CustomTextField(label: 'Phone Number 1', controller: _phone1Controller),
                  const SizedBox(height: 16),
                  CustomTextField(label: 'Phone Number 2', controller: _phone2Controller),
                  const SizedBox(height: 16),
                  CustomTextField(label: 'Password', controller: _passwordController),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: _isAdmin,
                        onChanged: (value) => setState(() => _isAdmin = value!),
                      ),
                      const Text('Admin User', style: TextStyle(fontFamily: 'Roboto')),
                    ],
                  ),
                  CustomButton(
                    text: AppStrings.signup,
                    onPressed: () {
                      final user = User(
                        id: const Uuid().v4(),
                        name: _nameController.text,
                        email: _emailController.text,
                        phone1: _phone1Controller.text,
                        phone2: _phone2Controller.text.isEmpty ? null : _phone2Controller.text,
                        profilePicture: null,
                        isAdmin: _isAdmin,
                      );
                      context.read<AuthBloc>().add(
                        SignupEvent(user, _passwordController.text),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}