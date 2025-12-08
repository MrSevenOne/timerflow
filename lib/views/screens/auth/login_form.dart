import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:timerflow/providers/auth/auth_viewmodel.dart';
import 'package:timerflow/routing/app_router.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();

  void _showSnack(String title, String message, ContentType type) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: type,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authVM, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // EMAIL
            TextField(
              controller: emailC,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),
            const SizedBox(height: 16),

            // PASSWORD
            TextField(
              controller: passwordC,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
              ),
            ),
            const SizedBox(height: 24),

            // LOGIN BUTTON
            SizedBox(
              height: 48.0,
              child: ElevatedButton(
                onPressed: authVM.isLoading
                    ? null
                    : () async {
                        final ok = await authVM.login(
                          emailC.text.trim(),
                          passwordC.text.trim(),
                        );

                        if (!ok) {
                          // EMAIL NOT CONFIRMED xatosi
                          if (authVM.errorMessage != null &&
                              authVM.errorMessage!
                                  .toLowerCase()
                                  .contains("email not confirmed")) {
                            _showSnack(
                              "Warning",
                              "Your email is not confirmed. Check your inbox.",
                              ContentType.warning,
                            );
                          } else {
                            _showSnack(
                              "Error",
                              authVM.errorMessage ?? "Login failed",
                              ContentType.failure,
                            );
                          }
                        } else {
                          _showSnack(
                            "Success",
                            "Login successful",
                            ContentType.success,
                          );

                          // Navigate to home page
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRouter.rootNavigation,
                            (_) => false,
                          );
                        }
                      },
                child: authVM.isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Login"),
              ),
            ),
          ],
        );
      },
    );
  }
}
