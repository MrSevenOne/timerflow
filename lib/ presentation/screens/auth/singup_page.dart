import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:timerflow/routers/app_routers.dart';
import 'package:timerflow/%20presentation/providers/auth/auth_provider.dart';
import 'package:timerflow/%20presentation/providers/user_viewmodel.dart';
import 'package:timerflow/domain/models/user_model.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, viewModel, _) {
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
                child: _SignupForm(viewModel: viewModel),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SignupForm extends StatefulWidget {
  final AuthProvider viewModel;

  const _SignupForm({required this.viewModel});

  @override
  State<_SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<_SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _signUp() async {
    final userModel = UserModel(
      name: _name.text.trim(),
      email: _email.text.trim(),
      password: _password.text.trim(),
    );

    if (_formKey.currentState!.validate()) {
      await widget.viewModel.signUp(userModel: userModel);
      if (widget.viewModel.error == null && context.mounted) {
        Provider.of<UserProvider>(context, listen: false).addUser(userModel);
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.tariff,
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isTablet = ResponsiveBreakpoints.of(context).isTablet;
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

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
            'sign_up'.tr,
            style: theme.textTheme.headlineMedium!.copyWith(fontSize: titleSize),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _name,
            decoration: InputDecoration(labelText: 'name'.tr),
            validator: (value) =>
                value == null || value.isEmpty ? 'name_input'.tr : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _email,
            decoration: InputDecoration(labelText: 'email'.tr),
            validator: (value) {
              if (value == null || value.isEmpty) return 'email_input'.tr;
              if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value)) {
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
            validator: (value) =>
                value == null || value.isEmpty ? 'ac_pass_input'.tr : null,
          ),
          const SizedBox(height: 16),
          widget.viewModel.isLoading
              ? const CircularProgressIndicator()
              : SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _signUp,
                    child: Text('signup_button'.tr),
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
                "have_account?".tr,
                style:
                    theme.textTheme.titleSmall!.copyWith(fontSize: textSize),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.login,
                    (route) => false,
                  );
                },
                child: Text(
                  'login'.tr,
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
