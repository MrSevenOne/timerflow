import 'package:flutter/material.dart';
import 'package:timerflow/data/repositories/database/session_repository.dart';
import 'package:timerflow/domain/models/session_model.dart';

class SessionViewModel extends ChangeNotifier {
  final SessionRepository _sessionRepository;

  SessionViewModel(this._sessionRepository);

  SessionModel? _session;
  bool _isLoading = false;
  String? _error;

  SessionModel? get session => _session;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Fetch session by ID
  Future<void> fetchSessionById(int id) async {
    _setLoading(true);
    try {
      _session = await _sessionRepository.getSessionById(id: id);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _session = null;
    } finally {
      _setLoading(false);
    }
  }

  // Add new session
  Future<void> addSession({
    required SessionModel sessionModel,
    required int tableId,
    required String status,
  }) async {
    _setLoading(true);
    try {
      await _sessionRepository.addSession(
        sessionModel: sessionModel,
        tableId: tableId,
        status: status,
      );
      _error = null;
    } catch (e) {
      _error = e.toString();
      debugPrint('AddSession Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Delete session
  Future<void> deleteSession(int id) async {
    _setLoading(true);
    try {
      await _sessionRepository.deleteSession(id: id);
      _session = null;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
