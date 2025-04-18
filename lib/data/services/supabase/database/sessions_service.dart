import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../domain/models/sessions_model.dart';

class ActiveSessionService {
  final _client = Supabase.instance.client;
  final activeSessionTable = 'active_sessions';

  Future<List<SessionModel>> getSessions() async {
    final response = await _client
        .from(activeSessionTable)
        .select('*, tables(*)')
        .order('id', ascending: false);

    return (response as List).map((e) => SessionModel.fromJson(e)).toList();
  }

//CREATE
  Future<SessionModel> createSession({required int tableId}) async {
    final response = await _client
        .from(activeSessionTable)
        .insert({
          'table_id': tableId,
          'start_time': DateTime.now().toIso8601String(),
        })
        .select('*, tables(*)')
        .single();

    return SessionModel.fromJson(response);
  }

  Future<SessionModel> endSession(SessionModel session) async {
    final now = DateTime.now();
    final durationInHours = now.difference(session.startTime!).inMinutes / 60.0;
    final price = durationInHours * (session.table?.rate_per_hour ?? 0);

    final updated = await _client
        .from(activeSessionTable)
        .update({
          'end_time': now.toIso8601String(),
          'duration': durationInHours,
          'total_amount': price,
        })
        .eq('id', session.id)
        .select('*, tables(*)')
        .single();

    return SessionModel.fromJson(updated);
  }
  

  Future<void> deleteSession(int id) async {
    await _client.from(activeSessionTable).delete().eq('id', id);
  }

  Future<SessionModel?> getActiveSessionByTableId(
      {required int tableId}) async {
    try {
      final response = await _client
          .from(activeSessionTable)
          .select('*, tables(*)')
          .eq('table_id', tableId)
          // .isFilter('end_time', null) // faqat tugamagan sessiya
          .limit(1)
          .maybeSingle();

      if (response == null) return null;
      return SessionModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to get active session by tableId: $e');
    }
  }
}
