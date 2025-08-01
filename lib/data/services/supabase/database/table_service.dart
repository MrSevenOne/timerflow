import 'package:timerflow/exports.dart';

class TableService extends BaseService {
  TableService() : super('tables');

  Future<List<TableModel>> getAllTables() async {
    checkUserId();

    try {
      final response = await supabase
          .from(tableName)
          .select()
          .eq('user_id', currentUserId!)
          .order('created_at', ascending: false);

      return (response as List)
          .map((e) => TableModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint('Stollar yuklanmadi: $e');
      throw Exception('Stollar yuklanmadi: $e');
    }
  }

  Future<TableModel> getTableById(String id) async {
    checkUserId();

    try {
      final response = await supabase
          .from(tableName)
          .select()
          .eq('id', id)
          .eq('user_id', currentUserId!)
          .single();

      return TableModel.fromJson(response);
    } catch (e) {
      throw Exception('Stol topilmadi: $e');
    }
  }

  Future<void> addTable(TableModel table) async {
    checkUserId();

    try {
      await supabase
          .from(tableName)
          .insert(table.copyWith(userId: currentUserId).toJson());
    } catch (e) {
      throw Exception('Stol qo\'shilmadi: $e');
    }
  }

 Future<TableModel?> startTable(String tableId) async {
  checkUserId();

  try {
    final nowUtc = DateTime.now().toUtc().toIso8601String();

    final response = await supabase
        .from('tables')
        .update({
          'status': 'busy',
          'updated_at': nowUtc,
        })
        .eq('id', tableId)
        .eq('user_id', currentUserId!)
        .select()
        .maybeSingle();

    return response != null ? TableModel.fromJson(response) : null;
  } catch (e) {
    debugPrint("Start Table error: $e");
    throw Exception("Start Table error: $e");
  }
}


  Future<TableModel?> endTable(String tableId) async {
  checkUserId();

  try {
    final nowUtc = DateTime.now().toUtc().toIso8601String();

    final response = await supabase
        .from(tableName)
        .update({
          'status': 'free',
          'updated_at': nowUtc,
        })
        .eq('id', tableId)
        .eq('user_id', currentUserId!)
        .select()
        .maybeSingle();

    return response != null ? TableModel.fromJson(response) : null;
  } catch (e) {
    debugPrint("End Table Error: $e");
    throw Exception("End Table Error: $e");
  }
}


  Future<void> updateTable(TableModel table) async {
    checkUserId();

    try {
      await supabase
          .from(tableName)
          .update(table.toJson())
          .eq('id', table.id!)
          .eq('user_id', currentUserId!);
    } catch (e) {
      throw Exception('Stol yangilanmadi: $e');
    }
  }

  Future<TableModel?> updateStatus({
  required String tableId,
  required String status,
}) async {
  checkUserId();

  try {
    final nowUtc = DateTime.now().toUtc().toIso8601String();

    final response = await supabase
        .from('tables')
        .update({
          'status': status,
          'updated_at': nowUtc,
        })
        .eq('id', tableId)
        .eq('user_id', currentUserId!)
        .select()
        .maybeSingle();

    if (response == null) {
      debugPrint('Table not found for id: $tableId');
      return null;
    }

    return TableModel.fromJson(response);
  } catch (e) {
    debugPrint('updateStatus error: $e');
    throw Exception('updateStatus error: $e');
  }
}


  Future<void> deleteTable(String id) async {
    checkUserId();

    try {
      await supabase
          .from(tableName)
          .delete()
          .eq('id', id)
          .eq('user_id', currentUserId!);
    } catch (e) {
      throw Exception('Stol o\'chirilmadi: $e');
    }
  }
}
