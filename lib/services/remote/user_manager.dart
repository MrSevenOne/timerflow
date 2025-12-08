import 'package:supabase_flutter/supabase_flutter.dart';

class UserManager {
  final SupabaseClient _client = Supabase.instance.client;

  /// Auth orqali login qilgan user
  User? get currentUser => _client.auth.currentUser;

  /// Login qilgan user id
  String? get userId => _client.auth.currentUser?.id;

  /// User login bo‘lgan yoki yo‘qligini tekshiradi
  bool get isLoggedIn => _client.auth.currentUser != null;

  /// User login bo‘lmagan bo‘lsa Exception tashlaydi
  String requireUserId() {
    final uid = _client.auth.currentUser?.id;
    if (uid == null) {
      throw Exception("User not logged in");
    }
    return uid;
  }
}
