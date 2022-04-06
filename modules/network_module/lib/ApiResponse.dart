import 'package:network_module/AppException.dart';

class ApiResponse<T> {
  Status status;

  T? data;

  String? message;

  ErrorType? errorType;

  ApiResponse.loading(this.message) : status = Status.LOADING;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.error(this.errorType, this.message) : status = Status.ERROR;

  ApiResponse.clear() : status = Status.CLEAR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR, CLEAR }