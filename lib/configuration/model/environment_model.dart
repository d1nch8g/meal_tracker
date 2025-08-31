import 'package:meal_tracker/di/interfaces/i_environment.dart';

/// Модель: Окружение
class EnvironmentModel implements IEnvironment {
  const EnvironmentModel({required this.environment, required this.name, required this.baseUrl, required this.apiRoot, required this.apiRootMap});

  const EnvironmentModel.test()
    : this(
        environment: EnvironmentType.test,
        name: 'Debug',
        baseUrl: 'https://appname.ru',
        apiRoot: 'https://appname.ru/Api/v1/',
        apiRootMap: const {'RUS': 'https://appname.ru/Api/v1/'},
      );

  const EnvironmentModel.prod()
    : this(
        environment: EnvironmentType.prod,
        name: 'Prod',
        baseUrl: 'https://appname.ru',
        apiRoot: 'https://appname.ru/Api/v1/',
        apiRootMap: const {'RUS': 'https://appname.ru/Api/v1/', 'BLR': 'https://appname.by/Api/v1/'},
      );

  factory EnvironmentModel.byEnv(EnvironmentType environment) {
    switch (environment) {
      case EnvironmentType.prod:
        return const EnvironmentModel.prod();
      default:
        return const EnvironmentModel.test();
    }
  }

  @override
  final EnvironmentType environment;
  @override
  final String name;
  @override
  final String baseUrl;
  @override
  final String apiRoot;
  @override
  final Map<String, String> apiRootMap;
}
