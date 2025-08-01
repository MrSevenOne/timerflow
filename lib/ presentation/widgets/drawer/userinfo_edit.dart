import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:timerflow/config/constant/app_constant.dart';
import 'package:timerflow/domain/models/user_model.dart';
import 'package:timerflow/exports.dart';

class EditProfilePage extends StatefulWidget {
  final UserModel userModel;

  const EditProfilePage({super.key, required this.userModel});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameController =
        TextEditingController(text: widget.userModel.name);
    _emailController = TextEditingController(text: widget.userModel.email);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final updatedUser = widget.userModel.copyWith(
      name: _usernameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    final userViewModel = context.read<UserProvider>();
    await userViewModel.updateFullUser(updatedUser);

    if (userViewModel.error!.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profil yangilandi")),
        );
        Navigator.pop(context);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Xatolik: ${userViewModel.error}")),
      );
      debugPrint("Xato Saqlash: ${userViewModel.error}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<UserProvider>().isLoading;

    final breakpoints = ResponsiveBreakpoints.of(context);
    final isDesktop = breakpoints.isDesktop;
    final isTablet = breakpoints.isTablet;

    final double titleSize = isDesktop
        ? 28
        : isTablet
            ? 24
            : 20;
    final double inputTextSize = isDesktop
        ? 18
        : isTablet
            ? 16
            : 14;

    return Scaffold(
      appBar: AppBar(title: const Text('Profilni tahrirlash')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isDesktop
                  ? 600
                  : isTablet
                      ? 480
                      : 400,
            ),
            child: AbsorbPointer(
              absorbing: isLoading,
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(labelText: "Foydalanuvchi nomi"),
                      style: TextStyle(fontSize: inputTextSize),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ism bo‘sh bo‘lmasligi kerak";
                        }
                        if (value.length < 3) {
                          return "Ism kamida 3 ta harf bo‘lishi kerak";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: "Email"),
                      style: TextStyle(fontSize: inputTextSize),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email kiritilishi kerak";
                        }
                        final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(value)) {
                          return "Email formati noto‘g‘ri";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: "Yangi parol"),
                      style: TextStyle(fontSize: inputTextSize),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Parol kiritilishi kerak";
                        }
                        if (value.length < 6) {
                          return "Parol kamida 6 ta belgidan iborat bo‘lishi kerak";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: "Parolni tasdiqlang"),
                      style: TextStyle(fontSize: inputTextSize),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Parolni qayta kiriting";
                        }
                        if (value != _passwordController.text) {
                          return "Parollar mos emas";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  _updateProfile();
                                }
                              },
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : const Text("Saqlash"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
