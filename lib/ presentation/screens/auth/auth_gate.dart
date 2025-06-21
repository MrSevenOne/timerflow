import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/%20presentation/providers/auth/auth_viewmodel.dart';
import 'package:timerflow/%20presentation/screens/auth/login_page.dart';
import 'package:timerflow/%20presentation/screens/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
      body: StreamBuilder<({AuthChangeEvent event, Session? session})>(
        stream: authProvider.authState,
        builder: (context, snapshot) {
          // Loading indicator while stream connects
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final authState = snapshot.data;
          final session = authState?.session;

          if (session != null) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
