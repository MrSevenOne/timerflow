import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:timerflow/exports.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    // Navigator chaqirig'ini build tugagandan keyin amalga oshirish
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initApp();
    });
  }

  Future<void> _initApp() async {
    // Delay (optional) for visual splash effect
    await Future.delayed(const Duration(seconds: 2));

    final user = Supabase.instance.client.auth.currentUser;

    if (mounted) {
      if (user != null) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      } else {
        Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          const Spacer(), // Logoni markazda joylashtirish uchun
          Center(
            child: Image.asset(
              'assets/logo/app_logo.png',
              height: 150,
            ),
          ),
          const Spacer(), // Matnni pastga tushirish uchun
          Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: Text(
              'appName'.tr,
              style: GoogleFonts.pridi(
                textStyle: TextStyle(
                  color: mainColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
