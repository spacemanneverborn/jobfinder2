//This file contains a reusable widget for the profile form.
// lib/src/features/profile/presentation/widgets/profile_form.dart

import 'package:flutter/material.dart';

class ProfileForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController bioController;
  final VoidCallback onSave;

  ProfileForm({
    required this.nameController,
    required this.emailController,
    required this.bioController,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(labelText: 'Name'),
        ),
        TextField(
          controller: emailController,
          decoration: InputDecoration(labelText: 'Email'),
          readOnly: true,
        ),
        TextField(
          controller: bioController,
          decoration: InputDecoration(labelText: 'Bio'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: onSave,
          child: Text('Save'),
        ),
      ],
    );
  }
}
