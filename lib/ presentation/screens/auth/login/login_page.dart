import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/auth/auth_provider.dart';
import 'package:timerflow/routers/app_routers.dart';
import 'package:responsive_framework/responsive_framework.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: ResponsiveBreakpoints.of(context).isTablet
                      ? 400
                      : 500,
                ),
                child: _LoginForm(viewModel: viewModel),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LoginForm extends StatefulWidget {
  final AuthProvider viewModel;

  const _LoginForm({required this.viewModel});

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      await widget.viewModel.signIn(
        _email.text.trim(),
        _password.text.trim(),
      );
      if (widget.viewModel.error == null && context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.home,
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
     final breakpoints = ResponsiveBreakpoints.of(context);
    final isDesktop = breakpoints.isDesktop;
    final isTablet = breakpoints.isTablet;

    final double titleSize = isDesktop
        ? 28
        : isTablet
            ? 24
            : 20;
    final double textSize = isDesktop
        ? 18
        : isTablet
            ? 16
            : 14;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            'login'.tr,
            style: theme.textTheme.headlineMedium!
                .copyWith(fontSize: titleSize),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _email,
            decoration: InputDecoration(labelText: 'email'.tr),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'email_input'.tr;
              } else if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                  .hasMatch(value)) {
                return 'invalid_email'.tr;
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _password,
            obscureText: true,
            decoration: InputDecoration(labelText: 'ac_pass'.tr),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'ac_pass_input'.tr;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          widget.viewModel.isLoading
              ? const CircularProgressIndicator()
              : SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _login,
                    child: Text('login_button'.tr),
                  ),
                ),
          if (widget.viewModel.error != null) ...[
            const SizedBox(height: 12),
            Text(
              widget.viewModel.error!,
              style: const TextStyle(color: Colors.red),
            ),
          ],
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "don't_have_account?".tr,
                style: theme.textTheme.titleSmall!.copyWith(fontSize: textSize),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.signUp,
                    (route) => false,
                  );
                },
                child: Text(
                  'sign_up'.tr,
                  style: theme.textTheme.titleSmall!.copyWith(
                    fontSize: textSize,
                    color: theme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
