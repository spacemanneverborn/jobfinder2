import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Sign Up Method
  Future<void> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Auth errors
      switch (e.code) {
        case 'email-already-in-use':
          throw AuthException('The email address is already in use by another account.');
        case 'invalid-email':
          throw AuthException('The email address is not valid.');
        case 'operation-not-allowed':
          throw AuthException('Email/password accounts are not enabled.');
        case 'weak-password':
          throw AuthException('The password is too weak.');
        default:
          throw AuthException('An undefined error occurred.');
      }
    } catch (e) {
      // Handle any other errors
      throw AuthException('An error occurred during sign-up. Please try again.');
    }
  }

  // Log In Method
  Future<void> logIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Auth errors
      switch (e.code) {
        case 'invalid-email':
          throw AuthException('The email address is not valid.');
        case 'user-disabled':
          throw AuthException('The user account has been disabled.');
        case 'user-not-found':
          throw AuthException('No user found for this email.');
        case 'wrong-password':
          throw AuthException('Incorrect password.');
        default:
          throw AuthException('An undefined error occurred.');
      }
    } catch (e) {
      // Handle any other errors
      throw AuthException('An error occurred during login. Please try again.');
    }
  }

  // Reset Password Method
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Auth errors
      switch (e.code) {
        case 'invalid-email':
          throw AuthException('The email address is not valid.');
        case 'user-not-found':
          throw AuthException('No user found for this email.');
        default:
          throw AuthException('An undefined error occurred.');
      }
    } catch (e) {
      // Handle any other errors
      throw AuthException('An error occurred while sending the password reset email. Please try again.');
    }
  }
}

// Custom Exception Class for Authentication Errors
class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() {
    return 'AuthException: $message';
  }
}
