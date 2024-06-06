import '../data/auth_repository.dart';
import '../data/auth_exceptions.dart' as auth_exc; // Prefix the import

class AuthUseCase {
  final AuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<void> signUp(String email, String password, String confirmPassword) async {
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      throw auth_exc.AuthException('All fields are required.'); // Use the prefixed name
    }
    if (password != confirmPassword) {
      throw auth_exc.AuthException('Passwords do not match.'); // Use the prefixed name
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      throw auth_exc.AuthException('Invalid email format.'); // Use the prefixed name
    }
    try {
      await _authRepository.signUp(email, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logIn(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw auth_exc.AuthException('All fields are required.'); // Use the prefixed name
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      throw auth_exc.AuthException('Invalid email format.'); // Use the prefixed name
    }
    try {
      await _authRepository.logIn(email, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    if (email.isEmpty) {
      throw auth_exc.AuthException('Email is required.'); // Use the prefixed name
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      throw auth_exc.AuthException('Invalid email format.'); // Use the prefixed name
    }
    try {
      await _authRepository.resetPassword(email);
    } catch (e) {
      rethrow;
    }
  }
}
