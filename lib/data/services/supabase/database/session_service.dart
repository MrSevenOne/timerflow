import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/data/services/supabase/database/tables_service.dart';
import 'package:timerflow/domain/models/session_model.dart';
import 'package:timerflow/utils/user/user_manager.dart';

class SessionService {
  final supabase = Supabase.instance.client;
  TableService tableService = TableService();
  final tableName = 'session';

   // USER ID bo'yicha sessionlarni olish
  Future<List<SessionModel>> fetchSessionsByUser() async {
    final userId = UserManager.currentUserId;
    if (userId == null) {
      throw Exception('User ID topilmadi');
    }

    final response = await supabase
        .from(tableName)
        .select()
        .eq('user_id', userId)
        .order('start_time', ascending: false); // yoki kerakli ustun bo'yicha

    return (response as List).map((e) => SessionModel.fromJson(e)).toList();
  }

  // Barcha sessionlarni bog'langan jadval bilan birga olish
  Future<List<SessionModel>> getSessionsWithDetails() async {
    try {
      final response =
          await supabase.from(tableName).select('*, tables(*)');

      debugPrint('Sessions fetched: $response');
      return (response as List<dynamic>)
          .map((e) => SessionModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint('Error fetching sessions: $e');
      rethrow;
    }
  }

  // ID bo'yicha bitta sessionni olish
  Future<Map<String, dynamic>?> getSessionById(int id) async {
    try {
      final response = await supabase
          .from(tableName)
          .select('*, tables(*)')
          .eq('id', id)
          .single();

      debugPrint('Session fetched by id: $response');
      return Map<String, dynamic>.from(response);
    } catch (e) {
      debugPrint('Error fetching session by id: $e');
      return null;
    }
  }

  // tableId bo'yicha session olish (SENING YANGI FUNKSIYANG)
  Future<Map<String, dynamic>?> getSessionByTableId(int tableId) async {
    try {
      final response = await supabase
          .from(tableName)
          .select('*, tables(*)')
          .eq('table_id', tableId)
          .maybeSingle();

      debugPrint('Session fetched by tableId: $response');
      if (response == null) return null;
      return Map<String, dynamic>.from(response);
    } catch (e) {
      debugPrint('Error fetching session by tableId: $e');
      return null;
    }
  }

  // Session qo'shish
  Future<void> addSession({
    required SessionModel sessionModel,
    required int tableId,
    required int status,
  }) async {
    try {
      await supabase
          .from(tableName)
          .insert(sessionModel.toJson())
          ;

      await tableService.updateStatus(tableId: tableId, status: status);
      debugPrint('Session added successfully for tableId: $tableId');
    } catch (e) {
      debugPrint('Error adding session: $e');
      rethrow;
    }
  }

  // Sessionni yangilash
  Future<void> updateSession({
    required int id,
    required SessionModel sessionModel,
  }) async {
    try {
      await supabase
          .from(tableName)
          .update(sessionModel.toJson())
          .eq('id', id)
          ;

      debugPrint('Session updated successfully: $id');
    } catch (e) {
      debugPrint('Error updating session: $e');
      rethrow;
    }
  }

  // Sessionni o'chirish
  Future<void> deleteSession(int id) async {
    try {
      await supabase.from(tableName).delete().eq('id', id);

      debugPrint('Session deleted successfully: $id');
    } catch (e) {
      debugPrint('Error deleting session: $e');
      rethrow;
    }
  }
}
