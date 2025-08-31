part of '../error_helper.dart';

class ErrorHelperOptions extends Equatable {
  final Key? key;
  final AsyncCallback func;

  const ErrorHelperOptions({
    this.key,
    required this.func,
  });

  @override
  List<Object?> get props => [
        key,
        func,
      ];

  ErrorHelperOptions copyWith({
    Key? key,
    AsyncCallback? func,
  }) {
    return ErrorHelperOptions(
      key: key ?? this.key,
      func: func ?? this.func,
    );
  }
}
