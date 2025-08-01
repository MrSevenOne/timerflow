import 'dart:async';
import 'package:timerflow/%20presentation/screens/payment/payment_dialog.dart';
import 'package:timerflow/exports.dart';

class TableProvider with ChangeNotifier {
  final TableService _tableService;

  List<TableModel> _tables = [];
  bool _isLoading = false;
  String? _error;
  Timer? _timer;

  TableProvider(this._tableService);

  List<TableModel> get tables => _tables;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> getTables() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _tables = await _tableService.getAllTables();

      // ⏱️ Agar "busy" holatdagi stol bo‘lsa, timer boshlanadi
      final hasBusy = _tables.any((t) => t.status == 'busy');
      if (hasBusy) {
        _startTimer();
      } else {
        _stopTimer(); // busy yo'q bo‘lsa timerni to‘xtat
      }

      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> startTable({required String tableId}) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _tableService.startTable(tableId);
      await getTables();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> endTable({required String tableId}) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _tableService.endTable(tableId);
      await getTables();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
      for (final t in _tables) {
        debugPrint(
            "TABLE: ${t.name} | updatedAt: ${t.updatedAt} | isUtc: ${t.updatedAt?.isUtc}");
      }
    }
  }

  Future<void> addTable(TableModel table) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _tableService.addTable(table);
      await getTables(); // Yangilangan ro'yxatni olish
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateTableStatus(String tableId, String status) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _tableService.updateStatus(tableId: tableId, status: status);
      await getTables(); // Yangilangan ro'yxatni olish
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> handleEndSession({
    required BuildContext context,
    required TableModel table,
  }) async {
    try {
      final userId = UserManager.currentUserId!;
      final duration = DateTime.now().difference(table.updatedAt!.toLocal());
      final totalTime = duration.inMinutes / 60.0;
      final tableRevenue = totalTime * table.pricePerHour;
      final totalRevenue = tableRevenue;

      final tableReportModel = TableReportModel(
        userId: userId,
        tableId: table.id!,
        startDate: table.updatedAt!,
        endDate: DateTime.now(),
        totalHours: totalTime,
        tableRevenue: tableRevenue,
        productRevenue: 0.0,
        totalRevenue: totalRevenue,
      );

      await PaymentDialog.show(context, table, tableReportModel);
    } catch (e) {
      debugPrint("Sessiyani tugatishda xatolik: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Xatolik: $e")),
        );
      }
    }
  }

  /// ⏱ Timer orqali har sekundda UI yangilash
  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      notifyListeners();
    });
  }

  /// ⏹ Timerni to‘xtatish
  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  /// 🔚 ViewModel o‘chirilganda timer ham o‘chadi
  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }
}
