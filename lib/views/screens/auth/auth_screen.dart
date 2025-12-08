import 'package:flutter/material.dart';
import 'package:timerflow/utils/extension/theme_extension.dart';
import 'package:timerflow/views/responsive.dart';
import 'package:timerflow/views/screens/auth/login_form.dart';
import 'package:timerflow/views/screens/auth/registor_form.dart';
import 'package:easy_localization/easy_localization.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _mobileLayout(),
      tablet: _tabletLayout(),
      desktop: _desktopLayout(),
    );
  }

  // ------------------ MOBILE ------------------
  Widget _mobileLayout() {
    return  Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  isLogin ? "login".tr() : "register".tr(),
                  style:
                      const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                isLogin ? const LoginForm() : const RegisterForm(),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLogin
                          ? "no_account".tr()
                          : "have_account".tr(),
                      style: context.theme.textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () => setState(() => isLogin = !isLogin),
                      child: Text(
                        isLogin ? "register".tr() : "login".tr(),
                        style: context.theme.textTheme.bodyMedium!.copyWith(
                          color: context.theme.colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      
    );
  }

  // ------------------ TABLET ------------------
  Widget _tabletLayout() {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Center(
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(32),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  isLogin ? "login".tr() : "register".tr(),
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 25),
                isLogin ? const LoginForm() : const RegisterForm(),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLogin
                          ? "no_account".tr()
                          : "have_account".tr(),
                      style: context.theme.textTheme.bodyLarge,
                    ),
                    TextButton(
                      onPressed: () => setState(() => isLogin = !isLogin),
                      child: Text(
                        isLogin ? "register".tr() : "login".tr(),
                        style: context.theme.textTheme.bodyLarge!.copyWith(
                          color: context.theme.colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ------------------ DESKTOP ------------------
  Widget _desktopLayout() {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.blue.withOpacity(.1),
              child: Center(
                child: Text(
                  "welcome".tr(),
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: 450,
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isLogin ? "login".tr() : "register".tr(),
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 35),
                    isLogin ? const LoginForm() : const RegisterForm(),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isLogin
                              ? "no_account".tr()
                              : "have_account".tr(),
                          style: context.theme.textTheme.bodyMedium,
                        ),
                        TextButton(
                          onPressed: () => setState(() => isLogin = !isLogin),
                          child: Text(
                            isLogin ? "register".tr() : "login".tr(),
                            style: context.theme.textTheme.bodyMedium!.copyWith(
                              color: context.theme.colorScheme.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
