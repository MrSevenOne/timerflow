

import 'package:timerflow/%20presentation/screens/home/home_page.dart';
import 'package:timerflow/exports.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

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
