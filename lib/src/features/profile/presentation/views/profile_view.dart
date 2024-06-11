// lib/src/features/profile/presentation/views/profile_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/profile_view_model.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context);
    final userProfile = viewModel.userProfile;

    if (viewModel.isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (viewModel.errorMessage != null) {
      return Scaffold(
        body: Center(child: Text(viewModel.errorMessage!)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (userProfile != null) ...[
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(userProfile.profilePictureUrl),
              ),
              SizedBox(height: 20),
              TextField(
                controller: TextEditingController(text: userProfile.name),
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  viewModel.updateUserProfileField(name: value);
                },
              ),
              TextField(
                controller: TextEditingController(text: userProfile.email),
                decoration: InputDecoration(labelText: 'Email'),
                readOnly: true,
              ),
              TextField(
                controller: TextEditingController(text: userProfile.bio),
                decoration: InputDecoration(labelText: 'Bio'),
                onChanged: (value) {
                  viewModel.updateUserProfileField(bio: value);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  viewModel.saveUserProfile(viewModel.userProfile!);
                },
                child: Text('Save'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                child: Text('Next'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
