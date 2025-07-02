import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/config/constant/app_constant.dart';
import 'package:timerflow/routers/app_routers.dart';
import '../../providers/auth/auth_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login(AuthViewModel viewModel) async {
  if (_formKey.currentState!.validate()) {
    await viewModel.signIn(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
    
    if (viewModel.error == null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
        (Route<dynamic> route) => false,
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<AuthViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(AppConstant.padding),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: AppConstant.spacing,
                children: [
                  Text(
                    'login'.tr,
                    style: theme.textTheme.headlineMedium,
                  ),
                  SizedBox(height: 8),
                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'email'.tr),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'email_input'.tr;
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return 'invalid_email'.tr;
                      }
                      return null;
                    },
                  ),
                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'ac_pass'.tr),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ac_pass_input'.tr;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  viewModel.isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _login(viewModel),
                            child: Text('login_button'.tr),
                          ),
                        ),
                  if (viewModel.error != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      viewModel.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("don't_have_account?".tr,
                          style: theme.textTheme.titleSmall),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.signUp,
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Text(
                          'sign_up'.tr,
                          style: theme.textTheme.titleSmall!
                              .copyWith(color: theme.primaryColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
