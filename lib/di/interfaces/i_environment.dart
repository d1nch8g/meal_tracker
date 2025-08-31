enum EnvironmentType {
  test,
  prod,
}

abstract class IEnvironment {
  const IEnvironment({
    required this.environment,
    required this.name,
    required this.baseUrl,
    required this.apiRoot,
    // required this.apkUrl,
    required this.apiRootMap,
    // required this.apkUrlMap,
  });

  final EnvironmentType environment;
  final String name;
  final String baseUrl;
  final String apiRoot;
  // final String apkUrl;
  final Map<String, String> apiRootMap;
  // final Map<String, String> apkUrlMap;
}
