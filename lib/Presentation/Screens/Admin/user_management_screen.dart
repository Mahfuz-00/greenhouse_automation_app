import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Common/Constants/app_colors.dart';
import '../../../Common/Constants/app_values.dart';
import '../../../Core/Widgets/custom_background.dart';
import '../../../Core/Widgets/custom_button.dart';
import '../../Bloc/User/user_bloc.dart';
import '../../Bloc/User/user_event.dart';
import '../../Bloc/User/user_state.dart';
import '../../Widgets/user_form_widget.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: const Text('User Management')),
        body: Padding(
          padding: const EdgeInsets.all(AppValues.padding),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is UserLoaded) {
                return ListView.builder(
                  itemCount: state.users.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return CustomButton(
                        text: 'Add User',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => UserFormWidget(
                              onSubmit: (user) {
                                context.read<UserBloc>().add(AddUserEvent(user));
                              },
                            ),
                          );
                        },
                      );
                    }
                    final user = state.users[index - 1];
                    return Card(
                      child: ListTile(
                        title: Text(user.name),
                        subtitle: Text('${user.email} (${user.isAdmin ? 'Admin' : 'User'})'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => UserFormWidget(
                                    user: user,
                                    onSubmit: (updatedUser) {
                                      context.read<UserBloc>().add(EditUserEvent(updatedUser));
                                    },
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: AppColors.error),
                              onPressed: () {
                                context.read<UserBloc>().add(DeleteUserEvent(user.id));
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return const Text('Error loading users', style: TextStyle(color: AppColors.error));
            },
          ),
        ),
      ),
    );
  }
}