part of '../error_helper.dart';

abstract class IErrorInterceptorBase extends Equatable {
  void onError(ErrorData data);

  @override
  bool? get stringify => null;
}

class ErrorInterceptor extends IErrorInterceptorBase {
  final void Function(ErrorData data) errorCallBack;

  ErrorInterceptor(this.errorCallBack);

  @override
  void onError(ErrorData data) {
    errorCallBack(data);
  }

  @override
  List<Object?> get props => [errorCallBack];
}
