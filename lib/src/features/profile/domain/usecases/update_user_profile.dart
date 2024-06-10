// lib/src/features/profile/domain/usecases/update_user_profile.dart

// lib/src/features/profile/domain/usecases/update_user_profile.dart

import 'package:jobfinder2/src/features/profile/data/repositories/profile_repository.dart';
import '../entities/user_profile.dart';

class UpdateUserProfile {
  final ProfileRepository _repository;

  UpdateUserProfile(this._repository);

  Future<void> execute(UserProfile userProfile) async {
    await _repository.updateUserProfile(userProfile);
  }
}
