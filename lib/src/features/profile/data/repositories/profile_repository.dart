// lib/src/features/profile/data/repositories/profile_repository.dart

// lib/src/features/profile/data/repositories/profile_repository.dart
// lib/src/features/profile/data/repositories/profile_repository.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_profile.dart';

class ProfileRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserProfile> getUserProfile(String userId, String email) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
    if (!doc.exists) {
      // Create a new user profile if it doesn't exist
      await _createUserProfile(userId, email); // Pass email if available
      doc = await _firestore.collection('users').doc(userId).get();
    }
    return UserProfile(
      uid: doc['id'],
      name: doc['name'],
      email: doc['email'],
      bio: doc['bio'],
      profilePictureUrl: doc['profilePictureUrl'],
    );
  }

  Future<void> _createUserProfile(String userId, String email) async {
    await _firestore.collection('users').doc(userId).set({
      'id': userId,
      'name': '',
      'email': email,
      'bio': '',
      'profilePictureUrl': '',
    });
  }

  Future<void> updateUserProfile(UserProfile userProfile) async {
    await _firestore.collection('users').doc(userProfile.uid).update({
      'name': userProfile.name,
      'bio': userProfile.bio,
      'profilePictureUrl': userProfile.profilePictureUrl,
    });
  }
}
