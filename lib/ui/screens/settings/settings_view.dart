import 'package:meal_tracker/di/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'settings_vm.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsViewModel(context.read<DIManager>()),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(title: Text('Настройки')),
          body: ListView(children: [_ThemeButton(), _LogoutButton()]),
        );
      },
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: context.read<DIManager>().exit, child: Text('Выйти'));
  }
}

class _ThemeButton extends StatelessWidget {
  const _ThemeButton();

  @override
  Widget build(BuildContext context) {
    final vm = context.read<SettingsViewModel>();
    final isDatrkTheme = context.select((SettingsViewModel vm) => vm.isDarkTheme);
    return ListTile(
      leading: Icon(Icons.palette),
      title: Text('Темная тема'),
      trailing: Switch(
        value: isDatrkTheme,
        onChanged: (_) {
          vm.setTheme(isDatrkTheme ? ThemeData.light() : ThemeData.dark());
        },
      ),
    );
  }
}
