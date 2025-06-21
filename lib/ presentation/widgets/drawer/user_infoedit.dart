import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/config/constant/app_constant.dart';
import 'package:timerflow/domain/models/user_model.dart';
import 'package:timerflow/%20presentation/providers/auth/user_viewmodel.dart';

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
        TextEditingController(text: widget.userModel.username);
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
      username: _usernameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    final userViewModel = context.read<UserViewmodel>();
    await userViewModel.updateFullUser(updatedUser);

    if (userViewModel.error.isEmpty) {
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
    final isLoading = context.watch<UserViewmodel>().isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Profilni tahrirlash')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AbsorbPointer(
          absorbing: isLoading,
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              spacing: AppConstant.spacing,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _usernameController,
                  decoration:
                      const InputDecoration(labelText: "Foydalanuvchi nomi"),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Ism bo‘sh bo‘lmasligi kerak";
                    if (value.length < 3)
                      return "Ism kamida 3 ta harf bo‘lishi kerak";
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Email kiritilishi kerak";
                    final emailRegex =
                        RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value))
                      return "Email formati noto‘g‘ri";
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Yangi parol"),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Parol kiritilishi kerak";
                    if (value.length < 6)
                      return "Parol kamida 6 ta belgidan iborat bo‘lishi kerak";
                    return null;
                  },
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration:
                      const InputDecoration(labelText: "Parolni tasdiqlang"),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Parolni qayta kiriting";
                    if (value != _passwordController.text)
                      return "Parollar mos emas";
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
