import 'package:meal_tracker/domain/user.dart';
import 'package:meal_tracker/repo/local/authorized_user_repo_extension.dart';
import 'package:meal_tracker/repo/local/local_repository.dart';
import 'package:meal_tracker/repo/remote/error_helper/error_helper.dart';
import 'package:meal_tracker/repo/remote/extends/mock_auth_extend.dart';
import 'package:meal_tracker/repo/remote/rest_repository.dart';
import 'package:flutter/material.dart';

class DIManager with ChangeNotifier {
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
      router.replaceAll(HomeRoute());
    } else {
      router.replaceAll(AuthRoute());
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

  Future<void> _logoutFlow() async {
    await _localRepository.saveAuthorizedUser(null);
    _authorizedUser = null;
    notifyListeners();
    router.replaceAll(AuthRoute());
  }

  Future<void> _authorizeFlow(String login, String password) async {
    final authorizedUser = await _remoteRepository.authorizeByLogin(login: login, password: password);
    await _handleAutrorizeUser(authorizedUser);
  }

  Future<void> _handleAutrorizeUser(User user) async {
    _authorizedUser = user;
    notifyListeners();
    await _localRepository.saveAuthorizedUser(user);
    router.replaceAll(HomeRoute());
  }
}
