// lib/src/features/profile/presentation/views/profile_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../view_models/profile_view_model.dart';

class ProfileView extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context);
    final userProfile = viewModel.userProfile;

    if (userProfile != null) {
      nameController.text = userProfile.name;
      bioController.text = userProfile.bio;
    }

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
              GestureDetector(
                onTap: () async {
                  final picker = ImagePicker();
                  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    File image = File(pickedFile.path);
                    await viewModel.uploadProfilePicture(image);
                  }
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: userProfile.profilePictureUrl.isNotEmpty
                      ? NetworkImage(userProfile.profilePictureUrl)
                      : null,
                  child: userProfile.profilePictureUrl.isEmpty ? Icon(Icons.camera_alt) : null,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: nameController,
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
                controller: bioController,
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
            ],
          ],
        ),
      ),
    );
  }
}
