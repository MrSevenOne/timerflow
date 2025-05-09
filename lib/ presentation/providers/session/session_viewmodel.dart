import 'dart:async';
import 'package:flutter/material.dart';
import 'package:timerflow/data/repositories/database/session_repository.dart';
import 'package:timerflow/domain/models/session_model.dart';
import 'package:timerflow/utils/formatter/date_formatter.dart';

class SessionViewModel extends ChangeNotifier {
  final SessionRepository _sessionRepository;
  Timer? _timer;

  SessionModel? _session;
  bool _isLoading = false;
  String? _error;

  SessionViewModel(this._sessionRepository);

  SessionModel? get session => _session;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Elapsed time getter
  String get elapsedTime {
    if (_session == null) return '00:00';
    final now = DateTime.now();
    final difference = now.difference(_session!.start_time);
    return DateFormatter.formatDuration(difference);
  }

  /// Total price getter
  int get tablePrice {
    if (_session == null || _session!.tableModel == null) return 0;
    final now = DateTime.now();
    final duration = now.difference(_session!.start_time);
    final totalMinutes = duration.inMinutes;
    final pricePerMinute = _session!.tableModel!.price / 60;
    return (totalMinutes * pricePerMinute).round();
  }

  Future<void> fetchSessionById(int id) async {
    _setLoading(true);
    try {
      _session = await _sessionRepository.getSessionById(id: id);
      _error = null;
      if (_session != null) _startTimer();
    } catch (e) {
      _error = e.toString();
      _session = null;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchSessionByTableId({required int tableId}) async {
    _setLoading(true);
    try {
      final data =
          await _sessionRepository.getSessionbyTableId(tableId: tableId);
      debugPrint("Fetched session data: $data");

      _session = data;
      _error = null;

      if (_session != null) {
        _startTimer(); // Timer faqat session mavjud bo‘lsa ishlaydi
      } else {
        _stopTimer();  // Session yo‘q bo‘lsa timer to‘xtaydi
      }
    } catch (e) {
      _error = e.toString();
      _session = null;
      _stopTimer();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addSession({
    required SessionModel sessionModel,
    required int tableId,
    required int status,
  }) async {
    _setLoading(true);
    try {
      await _sessionRepository.addSession(
        sessionModel: sessionModel,
        tableId: tableId,
        status: status,
      );
      _error = null;
      // fetch again to get full data (e.g. joined tableModel)
      await fetchSessionByTableId(tableId: tableId);
    } catch (e) {
      _error = e.toString();
      debugPrint('AddSession Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteSession(int id) async {
    _setLoading(true);
    try {
      await _sessionRepository.deleteSession(id: id);
      _session = null;
      _error = null;
      _stopTimer();
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      notifyListeners(); // Har daqiqada UI yangilanadi
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }
}
