import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/routing/app_router.dart';
import 'package:timerflow/utils/extension/snackbar_extension.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    try {
      await Supabase.instance.client.auth.signOut();

      // Login page ga yo‘naltirish va eski route’larni o‘chirish
      Navigator.pushNamedAndRemoveUntil(
        // ignore: use_build_context_synchronously
        context,
        AppRouter.auth,
        (route) => false,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      context.showError('Logout failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: const Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
