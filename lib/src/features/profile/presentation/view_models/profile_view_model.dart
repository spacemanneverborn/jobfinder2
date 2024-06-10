// lib/src/features/profile/presentation/view_models/profile_view_model.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/usecases/get_user_profile.dart';
import '../../domain/usecases/update_user_profile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class ProfileViewModel extends ChangeNotifier {
  final GetUserProfile _getUserProfile;
  final UpdateUserProfile _updateUserProfile;

  UserProfile? _userProfile;
  UserProfile? get userProfile => _userProfile;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  ProfileViewModel({
    required GetUserProfile getUserProfile,
    required UpdateUserProfile updateUserProfile,
  })  : _getUserProfile = getUserProfile,
        _updateUserProfile = updateUserProfile {
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    _setLoading(true);
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        _userProfile = await _getUserProfile.execute(currentUser.uid, currentUser.email!);
      } else {
        _errorMessage = 'User not logged in';
      }
    } catch (e) {
      _errorMessage = 'Failed to load profile: $e';
    }
    _setLoading(false);
  }

  Future<void> saveUserProfile(UserProfile userProfile) async {
    _setLoading(true);
    try {
      await _updateUserProfile.execute(userProfile);
      _userProfile = userProfile;
    } catch (e) {
      _errorMessage = 'Failed to save profile: $e';
    }
    _setLoading(false);
  }

  void updateUserProfileField({String? name, String? bio}) {
    if (_userProfile != null) {
      _userProfile = _userProfile!.copyWith(
        name: name ?? _userProfile!.name,
        bio: bio ?? _userProfile!.bio,
      );
      notifyListeners();
    }
  }

  Future<void> uploadProfilePicture(File image) async {
    _setLoading(true);
    try {
      String userId = _userProfile?.uid ?? 'userId';
      Reference storageReference = FirebaseStorage.instance.ref().child('profile_pictures/$userId');
      UploadTask uploadTask = storageReference.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      if (_userProfile != null) {
        _userProfile = _userProfile!.copyWith(profilePictureUrl: downloadUrl);
        await saveUserProfile(_userProfile!);
      }
    } catch (e) {
      _errorMessage = 'Failed to upload profile picture: $e';
    }
    _setLoading(false);
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}