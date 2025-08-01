import 'package:timerflow/data/services/supabase/auth/auth_service.dart';
import 'package:timerflow/exports.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  final _supabase = Supabase.instance.client;
  get authState => _supabase.auth.onAuthStateChange;

  bool _isLoading = false;
  String? _error;
  User? _user;

  bool get isLoading => _isLoading;
  String? get error => _error;
  User? get user => _user;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? value) {
    _error = value;
    notifyListeners();
  }

  void _setUser(User? value) {
    _user = value;
    notifyListeners();
  }

  /// SIGN IN
  Future<void> signIn(String email, String password) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await _authService.signIn(email, password);
      _setUser(response?.user);
    } catch (e) {
      _setError("error_login".tr);
      debugPrint("SignIn Error: $e");
    }

    _setLoading(false);
  }

  /// SIGN UP
  Future<void> signUp({required UserModel userModel}) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await _authService.signUp(userModel.email, userModel.password);
      if (response?.user == null) {
        _setError("Email already registered or confirmation required.");
      } else {

        _userService.addUser(userModel: userModel);

        _setUser(response?.user);
      }
    } catch (e) {
      _setError("error_signup".tr);
      debugPrint("SignUp Error: $e");
    }

    _setLoading(false);
  }


  /// SIGN OUT
  Future<void> signOut(BuildContext context) async {
    _setLoading(true);
    try {
      await _authService.signOut();
      _setUser(null);

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.login, (route) => false);
      }
    } catch (e) {
      _setError("Sign out failed: $e");
    }
    _setLoading(false);
  }

  /// LOAD CURRENT USER (on app start)
  void loadCurrentUser() {
    _setUser(
      _authService.getCurrentUser(),
    );
  }
}
