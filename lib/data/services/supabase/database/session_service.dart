import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timerflow/data/services/supabase/database/tables_service.dart';
import 'package:timerflow/domain/models/session_model.dart';

class SessionService {
  final supabase = Supabase.instance.client;
  TableService tableService = TableService();
  final tableName = 'session';

  // Barcha sessionlarni bog'langan jadval bilan birga olish
  Future<List<SessionModel>> getSessionsWithDetails() async {
    final response = await supabase
        .from(tableName)
        .select('*, tables(*)'); // Agar foreign key bilan ulangan bo'lsa
    return response.map((e) => SessionModel.fromJson(e)).toList();
  }

  // ID bo'yicha bitta sessionni olish
  Future<Map<String, dynamic>?> getSessionById(int id) async {
    final response = await supabase
        .from(tableName)
        .select('*, tables(*)')
        .eq('id', id)
        .single(); // faqat bitta row kutiladi

    return Map<String, dynamic>.from(response);
  }

  // Qo'shish
  Future<void> addSession(
      {required SessionModel sessionModel,
      required int tableId,
      required String status}) async {
    await supabase.from(tableName).insert(sessionModel.toJson());
    await tableService.updateStatus(tableId: tableId, status: status);
  }

  // Tahrirlash
  Future<void> updateSession(
      {required int id, required SessionModel sessionModel}) async {
    final response = await supabase
        .from(tableName)
        .update(sessionModel.toJson())
        .eq('id', id);
    if (response.error != null) {
      throw Exception('Failed to update session: ${response.error!.message}');
    }
  }

  // O'chirish
  Future<void> deleteSession(int id) async {
    final response = await supabase.from(tableName).delete().eq('id', id);
    if (response.error != null) {
      throw Exception('Failed to delete session: ${response.error!.message}');
    }
  }
}
