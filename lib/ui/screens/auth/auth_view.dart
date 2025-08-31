import 'package:meal_tracker/ui/screens/auth/auth_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthVM(context.read()),
      builder: (context, child) {
        final vm = context.read<AuthVM>();
        final isLoading = context.select((AuthVM vm) => vm.isLoading);

        return Scaffold(
          appBar: AppBar(title: Text('Авторизация')),
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 400),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller: context.read<AuthVM>().loginController,
                            decoration: InputDecoration(labelText: 'Логин'),
                          ),
                          SizedBox(height: 16),
                          TextField(
                            controller: context.read<AuthVM>().passwordController,
                            decoration: InputDecoration(labelText: 'Пароль'),
                            obscureText: true,
                            onSubmitted: (_) {
                              vm.authorize();
                            },
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(onPressed: vm.authorize, child: Text('Войти')),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
