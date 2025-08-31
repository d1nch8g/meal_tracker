import 'package:meal_tracker/configuration/model/environment_model.dart';
import 'package:meal_tracker/di/interfaces/i_configuration.dart';
import 'package:meal_tracker/di/interfaces/i_environment.dart';

class BaseConfiguration implements IConfiguration {
  @override
  Future<void> init({required EnvironmentType environment}) async {
    _environment = environment;
    _environmentModel = EnvironmentModel.byEnv(environment);

    //_cameraList = await availableCameras();
  }

  // @override
  // String get apkPath {
  //   String fileName = 'ga_wms.apk';

  //   if (_downloadDirectory == null) {
  //     return '${_documentsDirectory.path}/$fileName';
  //   }

  //   return '${_downloadDirectory!.path}/$fileName';
  // }

  /// Environment ->
  late EnvironmentType _environment;

  @override
  EnvironmentType get environment => _environment;

  late EnvironmentModel _environmentModel;

  @override
  EnvironmentModel get environmentModel => _environmentModel;

  /// API root
  String get baseUrl => environmentModel.baseUrl;

  /// API root
  @override
  String get apiRoot => environmentModel.apiRoot;

  /// Наименование окружения
  @override
  String get environmentName => environmentModel.name;

  @override
  int get requestTimeout => 30 * 1000;

  // /// Периодичность опроса сервера, сек
  // @override
  // int get requestPeriod => 30;
}
