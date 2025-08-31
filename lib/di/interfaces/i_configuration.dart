import 'package:meal_tracker/configuration/model/environment_model.dart';
import 'package:meal_tracker/di/interfaces/i_environment.dart';

abstract class IConfiguration {
  String get apiRoot;

  int get requestTimeout;

  EnvironmentType get environment;

  EnvironmentModel get environmentModel;

  String get environmentName;

  Future<void> init({required EnvironmentType environment});
}
