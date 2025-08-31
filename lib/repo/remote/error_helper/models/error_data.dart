part of '../error_helper.dart';

class ErrorData extends Equatable {
  final Object error;
  final StackTrace stackTrace;
  final ErrorHelperOptions options;
  final DateTime dateTime;

  const ErrorData({
    required this.error,
    required this.options,
    required this.stackTrace,
    required this.dateTime,
  });

  @override
  List<Object?> get props => [
        error,
        options,
        stackTrace,
        dateTime,
      ];
}
