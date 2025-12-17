// lib/core/user_manager.dart
import 'package:supabase_flutter/supabase_flutter.dart';

class UserManager {
  static SupabaseClient get _client => Supabase.instance.client;

  static String get userId {
    final id = _client.auth.currentUser?.id;
    if (id == null) {
      throw Exception('User not authenticated');
    }
    return id;
  }
}
