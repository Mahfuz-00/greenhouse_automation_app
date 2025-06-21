import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../Common/Constants/app_colors.dart';
import '../../../Common/Constants/app_strings.dart';
import '../../../Core/Widgets/custom_background.dart';
import '../../../Core/Widgets/custom_button.dart';
import '../../Bloc/Auth/auth_bloc.dart';
import '../../Bloc/Auth/auth_event.dart';
import '../../Bloc/Auth/auth_state.dart';
import '../../Bloc/Greenhouse/greenhouse_bloc.dart';
import '../../Bloc/Greenhouse/greenhouse_state.dart';
import '../../Bloc/User/user_bloc.dart';
import '../../Bloc/User/user_state.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(AppStrings.appTitle),
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () => context.go('/admin_dashboard/profile'),
            ),
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthInitial) {
                  context.go('/login');
                }
              },
              child: IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () => context.read<AuthBloc>().add(LogoutEvent()),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomButton(
                text: 'Manage Greenhouses',
                onPressed: () => context.go('/admin_dashboard/greenhouse_management'),
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: 'Manage Users',
                onPressed: () => context.go('/admin_dashboard/user_management'),
              ),
              const SizedBox(height: 16),
              const Text('Users and Greenhouses:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Expanded(
                child: BlocBuilder<UserBloc, UserState>(
                  builder: (context, userState) {
                    return BlocBuilder<GreenhouseBloc, GreenhouseState>(
                      builder: (context, greenhouseState) {
                        if (userState is UserLoading || greenhouseState is GreenhouseLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (userState is UserLoaded && greenhouseState is GreenhouseLoaded) {
                          return ListView.builder(
                            itemCount: userState.users.length,
                            itemBuilder: (context, index) {
                              final user = userState.users[index];
                              final userGreenhouses = greenhouseState.greenhouses
                                  .where((g) => g.userId == user.id)
                                  .toList();
                              return Card(
                                child: ListTile(
                                  title: Text('${user.name} (${user.isAdmin ? 'Admin' : 'User'})'),
                                  subtitle: Text('Greenhouses: ${userGreenhouses.length}'),
                                ),
                              );
                            },
                          );
                        }
                        return const Text('Error loading data', style: TextStyle(color: AppColors.error));
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}