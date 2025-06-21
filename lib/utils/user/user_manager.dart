import 'package:supabase_flutter/supabase_flutter.dart';

class UserManager {
  static final SupabaseClient _supabase = Supabase.instance.client;

  /// Authentikatsiyadan o'tgan foydalanuvchining ID sini qaytaradi.
  static String? get currentUserId {
    return _supabase.auth.currentUser?.id;
  }
}
