
import 'package:timerflow/exports.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService;

  UserProvider(this._userService);

  UserModel? _currentUser;
  bool _isLoading = false;
  String? _error;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _error = message;
    notifyListeners();
  }

  void _setUser(UserModel? user) {
    _currentUser = user;
    notifyListeners();
  }

  /// Fetch current logged-in user from Supabase
  Future<void> loadCurrentUser() async {
    _setLoading(true);
    _setError(null);
    try {
      final user = await _userService.fetchCurrentUserInfo();
      _setUser(user);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Update user info (only 'users' table)
  Future<void> updateUser(UserModel userModel) async {
    _setLoading(true);
    _setError(null);
    try {
      await _userService.updateUser(userModel: userModel);
      _setUser(userModel);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Update both `users` table and auth user info
  Future<void> updateFullUser(UserModel userModel) async {
    _setLoading(true);
    _setError(null);
    try {
      await _userService.updateFullUser(userModel: userModel);
      _setUser(userModel);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Add a new user (e.g. after registration)
  Future<void> addUser(UserModel userModel) async {
    _setLoading(true);
    _setError(null);
    try {
      await _userService.addUser(userModel: userModel);
      _setUser(userModel);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Clear user state (e.g. on logout)
  void clearUser() {
    _currentUser = null;
    _error = null;
    notifyListeners();
  }
}
