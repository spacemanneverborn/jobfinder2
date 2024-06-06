import 'package:flutter/material.dart';
import 'package:jobfinder2/src/features/auth/data/auth_repository.dart' as auth_repo;
import 'package:jobfinder2/src/features/auth/data/auth_exceptions.dart' as auth_exc;
import 'package:jobfinder2/src/features/auth/domain/auth_use_case.dart';

class RegisterViewModel extends ChangeNotifier {
  final AuthUseCase _authUseCase;

  RegisterViewModel(this._authUseCase);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> signUp() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authUseCase.signUp(
        emailController.text,
        passwordController.text,
        confirmPasswordController.text,
      );
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
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
