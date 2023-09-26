// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:dio/dio.dart';
// import 'http_exceptions.dart';
//
// /// 錯誤處理攔截
// class ErrorInterceptor extends Interceptor {
//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) async {
//     /// 根据DioError创建HttpException
//     HttpException httpException = HttpException.create(err);
//
//     /// dio默认的错误实例，如果是没有网络，只能得到一个未知错误，无法精准的得知是否是无网络的情况
//     /// 这里对于断网的情况，给一个特殊的code和msg
//     if (err.type == DioErrorType.other) {
//       var connectivityResult = await (Connectivity().checkConnectivity());
//       if (connectivityResult == ConnectivityResult.none) {
//         httpException = HttpException(code: -100, msg: 'None Network.');
//       }
//     }
//
//     /// 将自定义的HttpException
//     err.error = httpException;
//
//     /// 调用父类，回到dio框架
//     super.onError(err, handler);
//   }
// }
