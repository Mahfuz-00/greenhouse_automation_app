import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Common/Constants/app_colors.dart';
import '../../../Common/Constants/app_values.dart';
import '../../../Core/Widgets/custom_background.dart';
import '../../Bloc/Auth/auth_bloc.dart';
import '../../Bloc/Auth/auth_state.dart';
import '../../Bloc/User/user_bloc.dart';
import '../../Bloc/User/user_event.dart';
import '../../Widgets/user_form_widget.dart';


class ProfileManagementScreen extends StatelessWidget {
  const ProfileManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: const Text('Profile Management')),
        body: Padding(
          padding: const EdgeInsets.all(AppValues.padding),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              if (authState is AuthAuthenticated) {
                return UserFormWidget(
                  user: authState.user,
                  isEditing: true,
                  onSubmit: (updatedUser) {
                    context.read<UserBloc>().add(EditUserEvent(updatedUser));
                    Navigator.pop(context);
                  },
                );
              }
              return const Text('Error loading profile', style: TextStyle(color: AppColors.error));
            },
          ),
        ),
      ),
    );
  }
}