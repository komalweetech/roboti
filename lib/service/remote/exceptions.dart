import 'package:roboti_app/app/language_constant.dart';

class AppException implements Exception {
  final String _message;
  final String _prefix;

  AppException(this._message, this._prefix);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message!, lcGlobal.errorDuringCommunication);
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message!, lcGlobal.invalidRequest);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? message])
      : super(message!, lcGlobal.unauthorisedRequest);
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message!, lcGlobal.invalidRequest);
}
