import 'package:supabase_flutter/supabase_flutter.dart';

class UserManager {
  static final SupabaseClient _supabase = Supabase.instance.client;

  /// Authentikatsiyadan o'tgan foydalanuvchining ID sini qaytaradi.
  static String? get currentUserId {
    return _supabase.auth.currentUser?.id;
  }
}

Map<String, dynamic> getUserIdAndTimestamp() {
  final userId = Supabase.instance.client.auth.currentUser?.id;
  if (userId == null) {
    throw Exception('User not authenticated');
  }
  return {
    'user_id': userId,
    'created_at': DateTime.now().toIso8601String(),
  };
}
