import 'package:flutter/material.dart';
import 'package:jobfinder2/src/features/auth/data/auth_repository.dart' as auth_repo;
import 'package:jobfinder2/src/features/auth/data/auth_exceptions.dart' as auth_exc;
import 'package:jobfinder2/src/features/auth/domain/auth_use_case.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  final AuthUseCase _authUseCase;

  ForgotPasswordViewModel(this._authUseCase);

  final TextEditingController emailController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> sendPasswordResetEmail() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authUseCase.resetPassword(emailController.text);
    } on auth_exc.AuthException catch (e) {
      _errorMessage = e.message;
    } catch (e) {
      _errorMessage = 'An unexpected error occurred.';
    }

    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
