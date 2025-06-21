import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../Common/Constants/app_values.dart';
import '../../Core/Widgets/custom_button.dart';
import '../../Core/Widgets/custom_text_field.dart';
import '../../Domain/Entity/user.dart';


class UserFormWidget extends StatefulWidget {
  final User? user;
  final bool isEditing;
  final Function(User) onSubmit;

  const UserFormWidget({super.key, this.user, this.isEditing = false, required this.onSubmit});

  @override
  _UserFormWidgetState createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phone1Controller = TextEditingController();
  final _phone2Controller = TextEditingController();
  bool _isAdmin = false;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _nameController.text = widget.user!.name;
      _emailController.text = widget.user!.email;
      _phone1Controller.text = widget.user!.phone1;
      _phone2Controller.text = widget.user!.phone2 ?? '';
      _isAdmin = widget.user!.isAdmin;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phone1Controller.dispose();
    _phone2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(label: 'Name', controller: _nameController),
            const SizedBox(height: AppValues.padding),
            CustomTextField(
              label: 'Email',
              controller: _emailController,
              isNumber: false,
              maxLength: widget.isEditing ? null : 255,
            ),
            const SizedBox(height: AppValues.padding),
            CustomTextField(label: 'Phone Number 1', controller: _phone1Controller),
            const SizedBox(height: AppValues.padding),
            CustomTextField(label: 'Phone Number 2', controller: _phone2Controller),
            const SizedBox(height: AppValues.padding),
            if (!widget.isEditing)
              Row(
                children: [
                  Checkbox(
                    value: _isAdmin,
                    onChanged: (value) => setState(() => _isAdmin = value!),
                  ),
                  const Text('Admin User', style: TextStyle(fontFamily: 'Roboto')),
                ],
              ),
          ],
        ),
      ),
      actions: [
        CustomButton(
          text: 'Submit',
          onPressed: () {
            final user = User(
              id: widget.user?.id ?? const Uuid().v4(),
              name: _nameController.text,
              email: _emailController.text,
              phone1: _phone1Controller.text,
              phone2: _phone2Controller.text.isEmpty ? null : _phone2Controller.text,
              profilePicture: widget.user?.profilePicture,
              isAdmin: _isAdmin,
            );
            widget.onSubmit(user);
          },
        ),
      ],
    );
  }
}