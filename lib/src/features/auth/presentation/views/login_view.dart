// lib/src/features/auth/presentation/views/login_view.dart
// lib/src/features/auth/presentation/views/login_view.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobfinder2/src/features/profile/data/repositories/profile_repository.dart';
import 'package:jobfinder2/src/features/profile/domain/usecases/get_user_profile.dart';
import 'package:jobfinder2/src/features/profile/domain/usecases/update_user_profile.dart';
import 'package:jobfinder2/src/features/profile/presentation/view_models/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:jobfinder2/src/features/auth/presentation/view_models/login_view_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobfinder2/src/features/profile/presentation/views/profile_view.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);

    // Listen for login success and navigate
    if (viewModel.user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (context) => ProfileViewModel(
              getUserProfile: GetUserProfile(ProfileRepository()),
              updateUserProfile: UpdateUserProfile(ProfileRepository()),
            ),
            child: ProfileView(),
          ),
        ));
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade600, Colors.blue.shade900],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 50),
                SvgPicture.asset(
                  'assets/logo.svg',
                  height: 100,
                ),
                SizedBox(height: 30),
                Text(
                  'Welcome Back',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'Login to your account',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                TextField(
                  controller: viewModel.emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white24,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: viewModel.passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white24,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: viewModel.login,
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgot_password');
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text(
                    'Don\'t have an account? Sign Up',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                if (viewModel.isLoading)
                  Center(child: CircularProgressIndicator(color: Colors.white)),
                if (viewModel.errorMessage != null)
                  Center(
                    child: Text(
                      viewModel.errorMessage!,
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
