import 'package:flutter/material.dart';
import 'package:timerflow/data/repositories/database/bar_repository.dart';
import 'package:timerflow/domain/models/order_model.dart';

class BarViewModel extends ChangeNotifier {
  final BarRepository _repository = BarRepository();

  List<BarModel> _bars = [];
  List<BarModel> get bars => _bars;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchBars() async {
    _isLoading = true;
    notifyListeners();

    try {
      _bars = await _repository.getBars();
      _error = null;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addBar(BarModel bar) async {
    await _repository.addBar(bar);
    await fetchBars();
  }

  Future<void> updateBar(BarModel bar) async {
    await _repository.updateBar(bar);
    await fetchBars();
  }

  Future<void> deleteBar(int id) async {
    await _repository.deleteBar(id);
    await fetchBars();
  }
}
