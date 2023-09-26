import 'package:dio/dio.dart';

class HttpException implements Exception {
  final String msg;
  final int code;

  HttpException({
    this.code = -1,
    this.msg = 'unknow error',
  });

  @override
  String toString() {
    return 'Http Error [$code]: $msg';
  }

  factory HttpException.create(DioError error) {
    /// dio异常
    switch (error.type) {
      case DioErrorType.cancel:
        {
          return HttpException(code: -1, msg: 'request cancel');
        }
      case DioErrorType.connectTimeout:
        {
          return HttpException(code: -1, msg: 'connect timeout');
        }
      case DioErrorType.sendTimeout:
        {
          return HttpException(code: -1, msg: 'send timeout');
        }
      case DioErrorType.receiveTimeout:
        {
          return HttpException(code: -1, msg: 'receive timeout');
        }
      case DioErrorType.response:
        {
          try {
            int statusCode = error.response?.statusCode ?? 0;
            // String errMsg = error.response.statusMessage;
            // return ErrorEntity(code: errCode, message: errMsg);
            switch (statusCode) {
              case 400:
                {
                  return HttpException(
                      code: statusCode, msg: 'Request syntax error');
                }
              case 401:
                {
                  return HttpException(
                      code: statusCode, msg: 'Without permission');
                }
              case 403:
                {
                  return HttpException(
                      code: statusCode, msg: 'Server rejects execution');
                }
              case 404:
                {
                  return HttpException(
                      code: statusCode, msg: 'Unable to connect to server');
                }
              case 405:
                {
                  return HttpException(
                      code: statusCode, msg: 'The request method is disabled');
                }
              case 500:
                {
                  return HttpException(
                      code: statusCode, msg: 'Server internal error');
                }
              case 502:
                {
                  return HttpException(
                      code: statusCode, msg: 'Invalid request');
                }
              case 503:
                {
                  return HttpException(
                      code: statusCode, msg: 'The server is down.');
                }
              case 505:
                {
                  return HttpException(
                      code: statusCode, msg: 'HTTP requests are not supported');
                }
              default:
                {
                  return HttpException(
                      code: statusCode,
                      msg: error.response?.statusMessage ?? 'unknow error');
                }
            }
          } on Exception catch (_) {
            return HttpException(code: -1, msg: 'unknow error');
          }
        }
      default:
        {
          return HttpException(code: -1, msg: error.message);
        }
    }
  }
}