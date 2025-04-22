import 'package:timerflow/data/services/supabase/database/drink_service.dart';
import 'package:timerflow/domain/models/drink_model.dart';

class DrinkRepository {
    final DrinkService _service;
  DrinkRepository(this._service);

  Future<List<DrinkModel>> getAllDrinks() => _service.fetchDrinks();
  Future<void> addDrink(DrinkModel drink) => _service.addDrink(drink);
  Future<void> updateDrink(DrinkModel drink) => _service.updateDrink(drink);
  Future<void> deleteDrink(int id) => _service.deleteDrink(id);
}
