import 'package:flutter/material.dart';
import 'package:jobfinder2/src/features/auth/presentation/views/login_view.dart';
import 'package:jobfinder2/src/features/auth/presentation/views/register_view.dart';
import 'package:jobfinder2/src/features/auth/presentation/views/forgot_password_view.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot_password';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
