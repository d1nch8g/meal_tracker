import 'package:meal_tracker/ui/screens/home/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:meal_tracker/ui/screens/settings/settings_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeVM(mainProvider: context.read()),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Home')),
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsView()));
              },
              child: const Text('Go to Settings'),
            ),
          ),
        );
      },
    );
  }
}
