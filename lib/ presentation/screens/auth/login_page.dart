import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/auth/auth_viewmodel.dart';
import 'package:timerflow/routers/app_routers.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (viewModel.error != null)
              Text(viewModel.error!, style: const TextStyle(color: Colors.red)),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            viewModel.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      viewModel.signIn(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );
                    },
                    child: const Text("Login"),
                  ),
            TextButton(
              onPressed: () {
                viewModel.signIn(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );
                Navigator.pushNamed(context, AppRoutes.home);
              },
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
