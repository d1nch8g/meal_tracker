import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';

part 'models/options.dart';
part 'models/error_data.dart';
part 'models/error_interceptor.dart';

class ErrorHelper {
  static Future<bool> catchError(
    AsyncCallback func, {
    Key? key,
    void Function(ErrorData data)? onError,
    Set<IErrorInterceptorBase> interceptors = const {},
  }) async {
    final options = ErrorHelperOptions(func: func, key: key);
    try {
      await options.func();
      return true;
    } catch (error, stackTrace) {
      final data = ErrorData(error: error, options: options, stackTrace: stackTrace, dateTime: DateTime.now());

      final allInterceptors = [
        ...interceptors,
        if (onError != null) ErrorInterceptor(onError),
      ];

      for (final interceptor in allInterceptors) {
        interceptor.onError(data);
      }

      return false;
    }
  }
}

abstract class IAppException implements Exception {
  String Function() get message;
}

class ApiError implements IAppException {
  const ApiError({
    required this.message,
    required this.statusCode,
  });

  @override
  final String Function() message;
  final int statusCode;

  @override
  String toString() {
    return message();
  }
}
