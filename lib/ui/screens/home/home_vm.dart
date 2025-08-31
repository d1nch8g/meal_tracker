import 'package:meal_tracker/di/main_provider.dart';
import 'package:flutter/widgets.dart';

class HomeVM with ChangeNotifier {
  final DIManager mainProvider;

  HomeVM({required this.mainProvider});

  void goToSettings() {
  }
}
