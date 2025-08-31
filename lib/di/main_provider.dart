import 'package:meal_tracker/domain/user.dart';
import 'package:meal_tracker/repo/local/authorized_user_repo_extension.dart';
import 'package:meal_tracker/repo/local/local_repository.dart';
import 'package:meal_tracker/repo/remote/error_helper/error_helper.dart';
import 'package:meal_tracker/repo/remote/extends/mock_auth_extend.dart';
import 'package:meal_tracker/repo/remote/rest_repository.dart';
import 'package:flutter/material.dart';
import 'package:meal_tracker/ui/screens/auth/auth_view.dart';
import 'package:meal_tracker/ui/screens/home/home_view.dart';

class DIManager with ChangeNotifier {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final LocalRepository _localRepository;
  final RestRepository _remoteRepository;

  DIManager({required LocalRepository localRepository, required RestRepository remoteRepository})
    : _localRepository = localRepository,
      _remoteRepository = remoteRepository {
    _checkAuthorization();
  }

  User? _authorizedUser;
  User? get authorizedUser => _authorizedUser;

  ThemeData _themeData = ThemeData.dark();
  ThemeData get themeData => _themeData;

  bool get isAuthorized => authorizedUser != null;

  Future<void> _checkAuthorization() async {
    final authorizedUser = await _localRepository.getAuthorizedUser();
    if (authorizedUser != null) {
      _handleAutrorizeUser(authorizedUser);
      _navigateToHome();
    } else {
      _navigateToAuth();
    }
  }

  Future<void> authorize({required String login, required String password}) async {
    await ErrorHelper.catchError(() => _authorizeFlow(login, password));
  }

  Future<void> logout() async {
    ErrorHelper.catchError(_logoutFlow);
  }

  void setTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void _navigateToHome() {
    final context = navigatorKey.currentContext;
    if (context != null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const HomeView()), (route) => false);
    }
  }

  void _navigateToAuth() {
    final context = navigatorKey.currentContext;
    if (context != null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const AuthView()), (route) => false);
    }
  }

  Future<void> _logoutFlow() async {
    await _localRepository.saveAuthorizedUser(null);
    _authorizedUser = null;
    notifyListeners();
    _navigateToAuth();
  }

  Future<void> _authorizeFlow(String login, String password) async {
    final authorizedUser = await _remoteRepository.authorizeByLogin(login: login, password: password);
    await _handleAutrorizeUser(authorizedUser);
  }

  Future<void> _handleAutrorizeUser(User user) async {
    _authorizedUser = user;
    notifyListeners();
    await _localRepository.saveAuthorizedUser(user);
    _navigateToHome();
  }
}
