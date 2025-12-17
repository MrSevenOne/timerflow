import 'package:timerflow/data/remote/network_service.dart';

abstract class BaseRepository {
  final NetworkService networkService;

  BaseRepository(this.networkService);

  Future<bool> get hasInternet => networkService.hasInternet;
}
