import 'dart:convert';
import 'dart:developer';

import 'package:meal_tracker/di/interfaces/i_environment.dart';
import 'package:meal_tracker/di/interfaces/i_rest_repository.dart';
import 'package:meal_tracker/repo/remote/error_helper/error_helper.dart';
import 'package:http/http.dart' as http;

class RestRepository implements IRestRepository {
  final IEnvironment config;

  RestRepository({required this.config, String? token}) : _token = token ?? '';

  String get baseApiUrl => config.baseUrl;

  String _token = '';
  String get token => _token;

  MapEntry<String, String> get headerAcceptAll => const MapEntry('accept', '*/*');
  MapEntry<String, String> get headerContentJson => const MapEntry('Content-Type', 'application/json');
  MapEntry<String, String> get headerContentMultipart => const MapEntry('Content-Type', 'multipart/form-data');
  MapEntry<String, String> get headerAuthToken => MapEntry('Authorization', 'Bearer $token');

  @override
  void setToken(String value) {
    _token = value;
  }

  ApiError _apiErrorFromJson(String data, int statusCode) {
    try {
      final json = jsonDecode(data);
      if (json['message'] != null) {
        return ApiError(message: () => json['message'], statusCode: statusCode);
      }
      return ApiError(message: () => data, statusCode: statusCode);
    } catch (e) {
      return ApiError(message: () => data, statusCode: statusCode);
    }
  }

  @override
  Future<String?> getRequest({required String url, Map<String, String>? headers, int requestTimeout = 30}) async {
    final res = await http.get(Uri.parse('$baseApiUrl$url'), headers: headers).timeout(Duration(seconds: requestTimeout));

    final resultStr = utf8.decode(res.bodyBytes);
    log('''
GET
$url
<<<=======>>>
${res.statusCode}
$resultStr
    ''');
    if (res.statusCode < 200 || res.statusCode > 204) {
      throw _apiErrorFromJson(resultStr, res.statusCode);
    }

    return resultStr;
  }

  @override
  Future<String?> postRequest({required String url, Map<String, String>? headers, Map<String, dynamic>? body, int requestTimeout = 30}) async {
    final res = await http.post(Uri.parse('$baseApiUrl$url'), headers: headers, body: jsonEncode(body)).timeout(Duration(seconds: requestTimeout));

    final resultStr = utf8.decode(res.bodyBytes);
    log('''
POST
$url
$body
<<<=======>>>
${res.statusCode}
$resultStr
    ''');

    if (res.statusCode < 200 || res.statusCode > 204) {
      throw _apiErrorFromJson(resultStr, res.statusCode);
    }
    return resultStr;
  }

  @override
  Future<String?> putRequest({required String url, Map<String, String>? headers, Map<String, dynamic>? body, int requestTimeout = 30}) async {
    final res = await http.put(Uri.parse('$baseApiUrl$url'), headers: headers, body: jsonEncode(body)).timeout(Duration(seconds: requestTimeout));

    final resultStr = utf8.decode(res.bodyBytes);
    log('''
PUT
$url
$body
<<<=======>>>
${res.statusCode}
$resultStr
    ''');
    if (res.statusCode < 200 || res.statusCode > 204) {
      throw _apiErrorFromJson(resultStr, res.statusCode);
    }
    return resultStr;
  }

  @override
  Future<String?> patchRequest({required String url, Map<String, String>? headers, Map<String, dynamic>? body, int requestTimeout = 30}) async {
    final res = await http.patch(Uri.parse('$baseApiUrl$url'), headers: headers, body: jsonEncode(body)).timeout(Duration(seconds: requestTimeout));

    final resultStr = utf8.decode(res.bodyBytes);
    log('''
PATCH
$url
$body
<<<=======>>>
${res.statusCode}
$resultStr
    ''');
    if (res.statusCode < 200 || res.statusCode > 204) {
      throw _apiErrorFromJson(resultStr, res.statusCode);
    }
    return resultStr;
  }

  @override
  Future<String?> deleteRequest({required String url, Map<String, String>? headers, Map<String, dynamic>? body, int requestTimeout = 30}) async {
    final res = await http.delete(Uri.parse('$baseApiUrl$url'), headers: headers, body: jsonEncode(body)).timeout(Duration(seconds: requestTimeout));

    final resultStr = utf8.decode(res.bodyBytes);
    log('''
DELETE
$url
$body
<<<=======>>>
${res.statusCode}
$resultStr
    ''');
    if (res.statusCode < 200 || res.statusCode > 204) {
      throw _apiErrorFromJson(resultStr, res.statusCode);
    }
    return resultStr;
  }

  @override
  Future<String?> multipartRequest({
    required String url,
    required List<int> bytes,
    Map<String, String>? headers,
    Map<String, String>? body,
    int requestTimeout = 30,
  }) async {
    final request = http.MultipartRequest('POST', Uri.parse('$baseApiUrl$url'));

    request.headers.addAll(headers ?? {});
    request.fields.addAll(body ?? {});
    request.files.add(http.MultipartFile.fromBytes('file', bytes));

    final res = await http.Response.fromStream(await request.send()).timeout(Duration(seconds: requestTimeout));

    final resultStr = utf8.decode(res.bodyBytes);
    log('''
MULTIPART
$url
$headers
$body
$bytes
<<<=======>>>
${res.statusCode}
$resultStr
    ''');
    if (res.statusCode < 200 || res.statusCode > 204) {
      throw _apiErrorFromJson(resultStr, res.statusCode);
    }
    return resultStr;
  }
}
