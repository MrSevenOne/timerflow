// import 'package:timerflow/exports.dart';

// class SessionViewModel with ChangeNotifier {
//   final SessionService _sessionService;

//   List<SessionModel> _sessions = [];
//   bool _isLoading = false;
//   String? _error;

//   SessionViewModel(this._sessionService);

//   List<SessionModel> get sessions => _sessions;
//   bool get isLoading => _isLoading;
//   String? get error => _error;

//   Future<void> loadSessions() async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       _sessions = await _sessionService.getSessions();
//       _error = null;
//     } catch (e) {
//       _error = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<void> addSession({required SessionModel sessionModel}) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();
//     try {
//       await _sessionService.addSession(sessionModel);
//     } catch (e) {
//       debugPrint("Add Session Error: $e");
//       throw "Add Session Error: $e";
//     } finally {}
//   }
// }
