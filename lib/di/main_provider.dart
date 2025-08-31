import 'package:meal_tracker/domain/user.dart';
import 'package:meal_tracker/repo/local/local_repository.dart';
import 'package:meal_tracker/repo/remote/rest_repository.dart';
import 'package:flutter/material.dart';

class DIManager with ChangeNotifier {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final LocalRepository localRepository;
  final RestRepository remoteRepository;

  DIManager({required this.localRepository, required this.remoteRepository, required User userData}) : _userData = userData;

  final User _userData;

  final ThemeData themeData = ThemeData.dark();

  void setTheme(ThemeData themeData) {
    themeData = themeData;
    notifyListeners();
  }

  void exit() {}
}
