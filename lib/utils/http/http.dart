import 'dart:async';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../app_config.dart';
import 'error_interceptor.dart';

enum HttpMethod {
  get,
  post,
  delete,
  put,
  patch,
  head,
}

class Http {
  static final Http _instance = Http._internal();

  factory Http() => _instance;
  static late final Dio dio;

  Http._internal() {
    // BaseOptions、Options、RequestOptions 都可以給予參數，參數部分都是後蓋前
    BaseOptions options = BaseOptions(
      connectTimeout: CONNECT_TIMEOUT,
      receiveTimeout: RECEIVE_TIMEOUT,
      headers: {},
    );

    dio = Dio(options);

    // 添加攔截器
    // dio.interceptors.add(ErrorInterceptor());

    // 添加內存緩存
    // dio.interceptors.add(NetCacheInterceptor());

    // 沒網路retry機制
    // dio.interceptors.add(
    //   RetryOnConnectionChangeInterceptor(
    //     requestRetrier: DioConnectivityRequestRetrier(
    //       dio: dio,
    //       connectivity: Connectivity(),
    //     ),
    //   ),
    // );

    // refreshtoken & retry
    // dio.interceptors.add(RefreshTokenInterceptor(
    //     dio: dio,
    //     connectivity: Connectivity(),
    //     options: RetryOptions(
    //       retries: RETRY_API_NUM,
    //       // Number of retries before a failure
    //       retryInterval: const Duration(seconds: RETRY_S),
    //       // Interval between each retry
    //       retryEvaluator: (error) => error.response?.statusCode == 401,
    //     )));

    // log
    dio.interceptors.add(LogInterceptor(
      request: HTTP_REQUEST_LOG,
      requestHeader: HTTP_REQUEST_HEADER_LOG,
      requestBody: HTTP_REQUEST_BODY_LOG,
      responseHeader: HTTP_RESPONSE_HEADER_LOG,
      responseBody: HTTP_RESPONSE_BODY_LOG,
      error: HTTP_ERROR_LOG,
    ));

    // 在debug模式下需要測試，可以使用代理，並且禁用https模式
    if (PROXY_ENABLE) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return "PROXY $PROXY_IP:$PROXY_PORT";
        };
        // 驗證https的部分一律返回true
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  /// 設定headers
  void setHeaders(Map<String, dynamic> map) {
    dio.options.headers.addAll(map);
  }

  /// setBaseURL
  void setBaseURL({baseUrl}) {
    dio.options.baseUrl = baseUrl;
  }

  /// 讀取本地配置
  Future<Map<String, dynamic>> getAuthorizationHeader() async {
    Map<String, dynamic> headers = {
      "App-Version": "123",
      "Accept-Language": "123",
      "Bearer": "123",
    };
    return headers;
  }

  /// 封装request方法
  Future request({
    required String path,
    required HttpMethod method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool showLoading = true,
    bool showErrorMessage = true,
  }) async {
    const Map methodValues = {
      HttpMethod.get: 'get',
      HttpMethod.post: 'post',
      HttpMethod.put: 'put',
      HttpMethod.delete: 'delete',
      HttpMethod.patch: 'patch',
      HttpMethod.head: 'head'
    };

    Options options = Options(
      method: methodValues[method],
      headers: await getAuthorizationHeader(),
    );

    try {
      if (showLoading) {
        EasyLoading.show(status: 'loading...');
      }
      Response response = await dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data;
    } on DioError catch (error) {
      HttpException httpException = error.error;
      if (showErrorMessage) {
        EasyLoading.showToast(httpException.message);
      }
    } finally {
      if (showLoading) {
        EasyLoading.dismiss();
      }
    }
  }
}
