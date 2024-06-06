// Define a custom exception class for authentication errors
class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() {
    return 'AuthException: $message';
  }
}

