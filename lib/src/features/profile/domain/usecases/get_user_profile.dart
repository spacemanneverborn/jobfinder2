// lib/src/features/profile/domain/usecases/get_user_profile.dart

// lib/src/features/profile/domain/usecases/get_user_profile.dart

import 'package:jobfinder2/src/features/profile/data/repositories/profile_repository.dart';
import '../entities/user_profile.dart';

class GetUserProfile {
  final ProfileRepository _repository;

  GetUserProfile(this._repository);

  Future<UserProfile> execute(String userId, String email) async {
    return await _repository.getUserProfile(userId, email);
  }
}
