import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobfinder2/src/features/auth/presentation/view_models/login_view_model.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login View'),
            TextField(
              controller: viewModel.emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: viewModel.passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: viewModel.login,
              child: Text('Login'),
            ),
            if (viewModel.isLoading)
              CircularProgressIndicator(),
            if (viewModel.errorMessage != null)
              Text(
                viewModel.errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
