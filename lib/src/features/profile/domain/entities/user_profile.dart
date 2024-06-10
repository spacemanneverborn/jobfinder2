//This file defines the user profile entity used within the domain layer. 
//It is a simple data class.
// lib/src/features/profile/domain/entities/user_profile.dart
// lib/src/features/profile/domain/entities/user_profile.dart

// lib/src/features/profile/domain/entities/user_profile.dart

class UserProfile {
  final String uid;
  final String name;
  final String email;
  final String profilePictureUrl;
  final String bio;

  UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    required this.profilePictureUrl,
    required this.bio,
  });

  UserProfile copyWith({
    String? uid,
    String? name,
    String? email,
    String? profilePictureUrl,
    String? bio,
  }) {
    return UserProfile(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      bio: bio ?? this.bio,
    );
  }
}
