import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/models/user_model.dart';
import 'package:timerflow/providers/auth/auth_viewmodel.dart';
import 'package:timerflow/utils/extension/snackbar_extension.dart';
import 'package:timerflow/views/screens/tariff/tariff_screen.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController nameC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();
  final TextEditingController confirmC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authVM, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameC,
              decoration: InputDecoration(labelText: 'name'.tr()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailC,
              decoration: InputDecoration(labelText: 'email'.tr()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordC,
              obscureText: true,
              decoration: InputDecoration(labelText: 'password'.tr()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: confirmC,
              obscureText: true,
              decoration: InputDecoration(labelText: 'confirm_password'.tr()),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 48.0,
              child: ElevatedButton(
                onPressed: authVM.isLoading
                    ? null
                    : () async {
                        final name = nameC.text.trim();
                        final email = emailC.text.trim();
                        final password = passwordC.text.trim();
                        final confirm = confirmC.text.trim();
                        final model = UserModel(
                          createdAt: DateTime.now(),
                          name: name,
                          email: email,
                          password: password,
                          status: false,
                        );

                        if (name.isEmpty ||
                            email.isEmpty ||
                            password.isEmpty ||
                            confirm.isEmpty) {
                          context.showWarning('all_fields_required'.tr());
                          return;
                        }

                        if (password.length < 6) {
                          context.showWarning('password_min'.tr());
                          return;
                        }

                        if (password != confirm) {
                          context.showWarning('password_mismatch'.tr());
                          return;
                        }

                        final success = await authVM.register(model);

                        if (!success) {
                          // ignore: use_build_context_synchronously
                          context.showError(
                              authVM.errorMessage ?? 'Register failed');
                        } else {
                          // ignore: use_build_context_synchronously
                          context.showSuccess('registration_success'.tr());
                          Navigator.pushAndRemoveUntil(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TariffScreen(),
                            ),
                            (Route<dynamic> route) =>
                                false, // eski barcha route’larni o‘chiradi
                          );
                        }
                      },
                child: authVM.isLoading
                    ? const CircularProgressIndicator()
                    : Text('register'.tr()),
              ),
            ),
          ],
        );
      },
    );
  }
}
