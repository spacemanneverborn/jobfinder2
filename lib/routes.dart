import 'package:flutter/material.dart';
import 'package:jobfinder2/test.dart';
import 'src/features/auth/presentation/views/login_view.dart';
import 'src/features/auth/presentation/views/register_view.dart';
import 'src/features/auth/presentation/views/forgot_password_view.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot_password';
  static const String test = '/test';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordView());
      case test:
        return MaterialPageRoute(builder: (_) => FirestoreExample());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
