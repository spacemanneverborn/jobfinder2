//This file contains a reusable widget for displaying and updating the profile picture.
// lib/src/features/profile/presentation/widgets/profile_picture.dart

import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onEdit;

  ProfilePicture({required this.imageUrl, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(imageUrl),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: IconButton(
            icon: Icon(Icons.edit),
            onPressed: onEdit,
          ),
        ),
      ],
    );
  }
}
