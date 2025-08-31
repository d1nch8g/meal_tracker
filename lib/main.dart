import 'package:meal_tracker/configuration/model/environment_model.dart';
import 'package:meal_tracker/di/main_provider.dart';
import 'package:meal_tracker/repo/local/local_repository.dart';
import 'package:meal_tracker/repo/remote/rest_repository.dart';
import 'package:flutter/material.dart';
import 'package:meal_tracker/ui/screens/auth/auth_view.dart';
import 'package:meal_tracker/ui/screens/home/home_view.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  runApp(const AppNameApp());
}

class AppNameApp extends StatelessWidget {
  const AppNameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [..._services],
      builder: (context, child) {
        final isAuthorized = context.select((DIManager diManager) => diManager.isAuthorized);
        final defaultRoute = isAuthorized ? const HomeView() : const AuthView();
        return MaterialApp(theme: ThemeData.dark(useMaterial3: true), debugShowCheckedModeBanner: false, home: defaultRoute);
      },
    );
  }

  List<SingleChildWidget> get _services {
    final localRepository = LocalRepository();
    final remoteRepo = RestRepository(config: _config);
    return [
      Provider<RestRepository>(create: (context) => remoteRepo),
      Provider<LocalRepository>(create: (context) => localRepository),
      ChangeNotifierProvider(
        create: (context) {
          return DIManager(localRepository: localRepository, remoteRepository: remoteRepo);
        },
      ),
    ];
  }

  EnvironmentModel get _config => EnvironmentModel.test();
}
