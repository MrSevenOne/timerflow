// import 'package:timerflow/exports.dart';

// class SessionService extends BaseService {
//   final TableService tableService = TableService();

//   SessionService() : super('sessions');

//   Future<List<SessionModel>> getSessions() async {
//     checkUserId();

//     try {
//       final response = await supabase
//           .from(tableName)
//           .select('*, tables(*)')
//           .eq('user_id', currentUserId!)
//           .order('start_time', ascending: false);

//       return (response as List).map((e) => SessionModel.fromJson(e)).toList();
//     } catch (e) {
//       throw Exception('Sessiyalar yuklanmadi: $e');
//     }
//   }

//   Future<SessionModel?> getSessionByTableId(String tableId) async {
//     checkUserId();

//     try {
//       final response = await supabase
//           .from(tableName)
//           .select('*, tables(*)')
//           .eq('table_id', tableId)
//           .eq('user_id', currentUserId!)
//           .maybeSingle();

//       return response != null ? SessionModel.fromJson(response) : null;
//     } catch (e) {
//       debugPrint('Sessiya topilmadi: $e');
//       return null;
//     }
//   }

//   Future<SessionModel?> addSession(SessionModel session) async {
//     checkUserId();

//     try {
//       final response = await supabase
//           .from(tableName)
//           .insert(session.toJson())
//           .select('*, tables(*)')
//           .single();
//       debugPrint("Add Session: true");
//       return SessionModel.fromJson(response);
//     } catch (e) {
//       throw Exception('Sessiya qo‘shilmadi: $e');
//     }
//   }

//   Future<void> deleteSession(String id) async {
//     checkUserId();

//     try {
//       await supabase
//           .from(tableName)
//           .delete()
//           .eq('id', id)
//           .eq('user_id', currentUserId!);
//     } catch (e) {
//       throw Exception('Sessiya o\'chirilmadi: $e');
//     }
//   }
// }
