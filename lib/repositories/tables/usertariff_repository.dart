import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/models/tariff_model.dart';
import 'package:timerflow/models/user_tariff_model.dart';

class UserTariffRepository {
  final SupabaseClient _client = Supabase.instance.client;

  // id bo‘yicha olish
  Future<UserTariffModel?> getById(int id) async {
    try {
      final data = await _client
          .from('user_tariffs')
          .select()
          .eq('id', id)
          .maybeSingle();
      if (data == null) return null;
      return UserTariffModel.fromMap(data);
    } catch (e) {
      throw Exception('Failed to fetch user tariff: $e');
    }
  }

  // UPSERT (user_id bo‘yicha yagona)
  Future<UserTariffModel> upsert(UserTariffModel userTariff) async {
    try {
      final data = await _client
          .from('user_tariffs')
          .upsert({
            'user_id': userTariff.userId,
            'tariff_id': userTariff.tariffId,
            'status': userTariff.status,
          }, onConflict: 'user_id')
          .select()
          .maybeSingle();

      return UserTariffModel.fromMap(data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to upsert user tariff: $e');
    }
  }

  // delete
  Future<bool> delete(int id) async {
    try {
      await _client.from('user_tariffs').delete().eq('id', id);
      return true;
    } catch (e) {
      throw Exception('Failed to delete user tariff: $e');
    }
  }

  // User_id bo‘yicha mavjudligini tekshiradi
  /// Auth orqali login qilgan user uchun mavjudligini tekshiradi
  Future<bool> hasUserTariffForCurrentUser() async {
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        // User login qilmagan
        return false;
      }

      final data = await _client
          .from('user_tariffs')
          .select()
          .eq('user_id', user.id)
          .maybeSingle();

      return data != null;
    } catch (e) {
      throw Exception('Failed to check user tariff for current user: $e');
    }
  }

  // 🚀🚀🚀 LOGIN BO‘LGAN USERNING TARIF LIMITINI OLIB KELISH
  Future<int> getCurrentUserTableLimit() async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) throw Exception("User not logged in");

      // 1️⃣ user_tariffs jadvalidan tarif_id ni olamiz
      final userTariff = await _client
          .from('user_tariffs')
          .select('tariff_id')
          .eq('user_id', user.id)
          .maybeSingle();

      if (userTariff == null) {
        throw Exception("User has no active tariff subscription");
      }

      final tariffId = userTariff['tariff_id'];

      // 2️⃣ tariffs jadvalidan table_limitni olamiz
      final tariffData = await _client
          .from('tariffs')
          .select()
          .eq('id', tariffId)
          .maybeSingle();

      if (tariffData == null) {
        throw Exception("Tariff not found");
      }

      final tariff = TariffModel.fromJson(tariffData);

      debugPrint(
          "Userga berilgan tariff bo'yicha tableCount: ${tariff.tableCount}");

      return tariff.tableCount;
    } catch (e) {
      throw Exception("Failed to fetch table limit: $e");
    }
  }
}
