//This file defines the data model for the user profile, including JSON serialization methods.
// lib/src/features/profile/data/models/user_profile_model.dart

class UserProfileModel {
  final String uid;
  final String name;
  final String email;
  final String profilePictureUrl;
  final String bio;

  UserProfileModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profilePictureUrl,
    required this.bio,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      uid: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profilePictureUrl: json['profilePictureUrl'] as String,
      bio: json['bio'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
      'bio': bio,
    };
  }
}
