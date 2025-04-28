import 'package:timerflow/data/services/supabase/database/session_service.dart';
import 'package:timerflow/domain/models/session_model.dart';

class SessionRepository {
  final SessionService service;
  SessionRepository(this.service);
  //getSessionById
  Future getSessionById({required int id}) => service.getSessionById(id);
  //addSession
  Future<void> addSession(
          {required SessionModel sessionModel,
          required int tableId,
          required String status}) =>
      service.addSession(
          sessionModel: sessionModel, tableId: tableId, status: status);
  //deleteSession
  Future deleteSession({required int id}) => service.deleteSession(id);
}
