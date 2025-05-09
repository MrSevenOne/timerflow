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
      body: StreamBuilder<AuthState>(
        stream: authProvider.authState,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final session = snapshot.data?.session;
          if (session != null) {
            return HomePage();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}