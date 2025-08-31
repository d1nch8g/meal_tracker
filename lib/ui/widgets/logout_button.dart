import 'package:meal_tracker/di/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: Icon(Icons.logout), onPressed: () => context.read<DIManager>().logout());
  }
}
