import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/routers/app_routers.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final supabase = Supabase.instance.client;
  RealtimeChannel? _subscription;

  @override
  void initState() {
    super.initState();
    _initStatusCheck();
  }

  void _initStatusCheck() async {
    final user = supabase.auth.currentUser;

    // Splash delay (2 soniya)
    await Future.delayed(const Duration(seconds: 2));

    if (user == null) {
      if (mounted) Navigator.pushReplacementNamed(context, AppRoutes.login);
      return;
    }

    final userId = user.id;

    // 1. Boshlang'ich status tekshirish
    final data = await supabase
        .from('users')
        .select('status')
        .eq('auth_id', userId)
        .maybeSingle();

    if (!mounted) return;

    final status = data?['status'];

    if (status == 1) {
      _navigateToHome();
    } else {
      _navigateToContactAdmin();
    }

    // 2. Doimiy kuzatish (Realtime listener)
    _subscription = supabase
        .channel('realtime:users')
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'users',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'auth_id',
            value: userId,
          ),
          callback: (payload) {
            final newStatus = payload.newRecord['status'];

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              if (newStatus == 1) {
                _navigateToHome();
              } else {
                _navigateToContactAdmin();
              }
            });
          },
        )
        .subscribe();
  }

  void _navigateToHome() {
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  void _navigateToContactAdmin() {
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, AppRoutes.contactAdmin);
  }

  @override
  void dispose() {
    _subscription?.unsubscribe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
  child: FractionallySizedBox(
    widthFactor: 0.5, // Ekran eni 50%
    child: Image.asset('assets/logo/app_logo.png'),
  ),
),

    );
  }
}
