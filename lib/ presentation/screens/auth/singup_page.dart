import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/auth/user_viewmodel.dart';
import 'package:timerflow/config/constant/app_constant.dart';
import 'package:timerflow/domain/models/user_model.dart';
import 'package:timerflow/routers/app_routers.dart';
import '../../providers/auth/auth_viewmodel.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signUp(AuthViewModel viewModel) async {
  if (_formKey.currentState!.validate()) {
    await viewModel.signUp(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (viewModel.error == null) {
      UserModel userModel = UserModel(
        username: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        status: "false",
      );
      // ignore: use_build_context_synchronously
      final userProvider = Provider.of<UserViewmodel>(context, listen: false);
      userProvider.addUser(userModel);

      // Foydalanuvchi muvaffaqiyatli ro'yxatdan o'tgan bo'lsa home sahifaga o'tkazish
      Navigator.pushNamedAndRemoveUntil(
        // ignore: use_build_context_synchronously
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
                    'sign_up'.tr,
                    style: theme.textTheme.headlineMedium,
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'name'.tr),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'name_input'.tr : null,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'email'.tr),
                    validator: (value) => value == null || value.isEmpty
                        ? 'email_input'.tr
                        : null,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'ac_pass'.tr),
                    obscureText: true,
                    validator: (value) => value == null || value.isEmpty
                        ? 'ac_pass_input'.tr
                        : null,
                  ),
                  SizedBox(height: 8.h),
                  viewModel.isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _signUp(viewModel),
                            child: Text('signup_button'.tr),
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
                      Text("have_account?".tr,style: theme.textTheme.titleSmall,),
                      TextButton(onPressed: () {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login, 
      (Route<dynamic> route) => false,
    );
  }, child: Text('login'.tr,style: theme.textTheme.titleSmall!.copyWith(color: theme.primaryColor),),),
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
