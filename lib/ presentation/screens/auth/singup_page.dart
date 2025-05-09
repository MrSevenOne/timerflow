import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/auth/user_viewmodel.dart';
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

  void _signUp(AuthViewModel viewModel) {
    if (_formKey.currentState!.validate()) {
      viewModel.signUp(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      UserModel userModel = UserModel(
        username: _nameController.text.trim(), 
      email: _emailController.text.trim(), 
      password: _passwordController.text.trim(), 
      status: false,
      );
      final userProvider = Provider.of<UserViewmodel>(context, listen: false);
      userProvider.addUser(userModel);

      //home pagega navigatsiya qiladi
      Navigator.pushNamed(context, AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "SignUp",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Ism'),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Ism kiriting' : null,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Email kiriting'
                        : null,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Parol'),
                    obscureText: true,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Parol kiriting'
                        : null,
                  ),
                  const SizedBox(height: 20),
                  viewModel.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () => _signUp(viewModel),
                          child: const Text("Ro'yxatdan o'tish"),
                        ),
                  if (viewModel.error != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      viewModel.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
