abstract interface class IRestRepository {
  void setToken(String token);

  Future<String?> getRequest({required String url, Map<String, String>? headers});
  Future<String?> deleteRequest({required String url, Map<String, String>? headers, Map<String, dynamic>? body});
  Future<String?> postRequest({required String url, Map<String, String>? headers, Map<String, dynamic>? body});
  Future<String?> putRequest({required String url, Map<String, String>? headers, Map<String, dynamic>? body});
  Future<String?> patchRequest({required String url, Map<String, String>? headers, Map<String, dynamic>? body});
  Future<String?> multipartRequest({
    required String url,
    required List<int> bytes,
    Map<String, String>? headers,
    Map<String, String>? body,
    int requestTimeout = 30,
  });
}

enum ApiMethod {
  post,
  get,
  put,
  patch,
  delete;
}
