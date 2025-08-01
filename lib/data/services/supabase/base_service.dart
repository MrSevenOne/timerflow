import '../../../exports.dart';

abstract class BaseService {
  final supabase = Supabase.instance.client;
  final String tableName;

  BaseService(this.tableName);

  String? get currentUserId {
    return UserManager.currentUserId;
  }

  void checkUserId() {
    if (currentUserId == null) {
      throw Exception('Foydalanuvchi ID topilmadi. Iltimos, avval tizimga kiring.');
    }
  }
}