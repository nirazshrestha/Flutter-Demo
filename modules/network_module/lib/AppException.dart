class AppException implements Exception {
  final _message;
  final ErrorType? _type;

  AppException([this._message, this._type]);

  String toString() {
    return "$_message";
  }

  Map<String, Object?> toError() {
    return {'errorType': _type, 'message': _message};
  }

}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, ErrorType.DATA_FETCH_ERROR);
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, ErrorType.BAD_REQUEST);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, ErrorType.UNAUTHORRIZED);
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, ErrorType.INVALID_INPUT_ERROR);
}

class TokenExpiredException extends AppException {
  TokenExpiredException([String? message]) : super(message, ErrorType.TOKEN_EXPIRED);
}

enum ErrorType { TOKEN_EXPIRED, UNAUTHORRIZED, BAD_REQUEST, DATA_FETCH_ERROR, INVALID_INPUT_ERROR }