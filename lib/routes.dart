import 'package:flutter/material.dart';
import 'src/features/auth/presentation/views/login_view.dart';
import 'src/features/auth/presentation/views/register_view.dart';
import 'src/features/auth/presentation/views/forgot_password_view.dart';
// lib/routes.dart


import 'src/features/profile/presentation/views/profile_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// lib/routes.dart

import 'package:flutter/material.dart';
import 'src/features/auth/presentation/views/login_view.dart';
import 'src/features/auth/presentation/views/register_view.dart';
import 'src/features/auth/presentation/views/forgot_password_view.dart';
import 'src/features/profile/presentation/views/profile_view.dart';
import 'src/features/profile/presentation/views/home_view.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot_password';
  static const String profile = '/profile';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordView());
      case profile:
        return MaterialPageRoute(builder: (_) => ProfileView());
      case home:
        return MaterialPageRoute(builder: (_) => HomeView());
      default:
        return MaterialPageRoute(builder: (_) => LoginView());
    }
  }
}
