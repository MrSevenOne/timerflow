import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/data/services/supabase/database/sessions_service.dart';
import 'package:timerflow/data/services/supabase/database/tables_service.dart';
import 'package:timerflow/domain/models/sessions_model.dart';
import 'package:timerflow/ui/auth/view_model/tables_viewmodel.dart';

class SessionViewModel extends ChangeNotifier {
  final ActiveSessionService _service = ActiveSessionService();
  final _tableService = TablesService(); // ✅ qo‘shildi
  List<SessionModel> _sessions = [];
  bool _isLoading = false;

  List<SessionModel> get sessions => _sessions;
  bool get isLoading => _isLoading;

  Future<void> fetchSessions() async {
    _isLoading = true;
    notifyListeners();

    _sessions = await _service.getSessions();

    _isLoading = false;
    notifyListeners();
  }

Future<void> startSession({required int tableId, required BuildContext context}) async {
  _isLoading = true;
  notifyListeners();

  final session = await _service.createSession(tableId: tableId);
  _sessions.insert(0, session);

  // ✅ TablesViewModel orqali band qilish
  // ignore: use_build_context_synchronously
  final tableVM = Provider.of<TablesViewModel>(context, listen: false);
  await tableVM.updateTableStatus(tableId: tableId, newStatus: "band");

  _isLoading = false;
  notifyListeners();
}


 Future<void> endSession({
  required SessionModel sessionModel,
  required BuildContext context,
}) async {
  _isLoading = true;
  notifyListeners();

  final updated = await _service.endSession(sessionModel);
  final index = _sessions.indexWhere((e) => e.id == updated.id);
  if (index != -1) {
    _sessions[index] = updated;
  }

  // ✅ TablesViewModel orqali bo‘sh qilish
  if (sessionModel.table?.id != null) {
    // ignore: use_build_context_synchronously
    final tableVM = Provider.of<TablesViewModel>(context, listen: false);
    await tableVM.updateTableStatus(
        tableId: sessionModel.table!.id!, newStatus: "bo'sh");
  }

  _isLoading = false;
  notifyListeners();
}


  Future<void> deleteSession(int id) async {
    await _service.deleteSession(id);
    _sessions.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  Future<SessionModel?> getActiveSessionByTableId(
      {required int tableId}) async {
    try {
      return await _service.getActiveSessionByTableId(tableId: tableId);
    } catch (e) {
      debugPrint('Error getting active session: $e');
      return null;
    }
  }
}
