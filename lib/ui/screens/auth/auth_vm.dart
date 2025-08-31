import 'package:meal_tracker/di/main_provider.dart';
import 'package:flutter/widgets.dart';

class AuthVM extends ChangeNotifier {
  final DIManager _mainProvider;
  AuthVM(this._mainProvider);

  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? errorMessage;

  void authorize() async {
    _isLoading = true;
    notifyListeners();
    final login = loginController.text;
    final password = passwordController.text;

    await _mainProvider.authorize(login: login, password: password);

    _isLoading = false;
    notifyListeners();
  }
}
