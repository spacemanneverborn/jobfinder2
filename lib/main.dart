// lib/main.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jobfinder2/src/features/profile/presentation/view_models/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'src/features/auth/presentation/views/login_view.dart';
import 'src/features/auth/presentation/views/register_view.dart';
import 'src/features/auth/presentation/views/forgot_password_view.dart';
import 'src/features/auth/presentation/view_models/login_view_model.dart';
import 'src/features/auth/presentation/view_models/register_view_model.dart';
import 'src/features/auth/presentation/view_models/forgot_password_view_model.dart';
import 'src/features/auth/domain/auth_use_case.dart';
import 'src/features/auth/data/auth_repository.dart';
import 'src/features/profile/domain/usecases/get_user_profile.dart';
import 'src/features/profile/domain/usecases/update_user_profile.dart';
import 'src/features/profile/data/repositories/profile_repository.dart';
import 'routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Use emulators if available
  bool useEmulators = bool.fromEnvironment('USE_EMULATORS', defaultValue: false);

  if (useEmulators) {
    FirebaseFirestore.instance.settings = Settings(
      host: 'localhost:8081',
      sslEnabled: false,
      persistenceEnabled: false,
    );
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }

  final authRepository = AuthRepository();
  final authUseCase = AuthUseCase(authRepository);

  runApp(MyApp(authUseCase: authUseCase));
}

class MyApp extends StatelessWidget {
  final AuthUseCase authUseCase;

  MyApp({required this.authUseCase});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(authUseCase),
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterViewModel(authUseCase),
        ),
        ChangeNotifierProvider(
          create: (_) => ForgotPasswordViewModel(authUseCase),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileViewModel(
            getUserProfile: GetUserProfile(ProfileRepository()),
            updateUserProfile: UpdateUserProfile(ProfileRepository()),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'JobFinder2',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: AppRoutes.login,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
