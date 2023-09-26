import 'http.dart';

/// https://blog.csdn.net/fangShiKang/article/details/127882096
class HttpUtils {
  static Http httpRequest = Http();

  static void setHeaders(Map<String, dynamic> map) {
    httpRequest.setHeaders(map);
  }

  static void setBaseURL(String baseUrl) {
    httpRequest.setBaseURL(baseUrl: baseUrl);
  }

  /// get
  static Future get({
    required String path,
    Map<String, dynamic>? queryParameters,
    bool showLoading = true,
    bool showErrorMessage = true,
  }) {
    return httpRequest.request(
      path: path,
      method: HttpMethod.get,
      queryParameters: queryParameters,
      showLoading: showLoading,
      showErrorMessage: showErrorMessage,
    );
  }

  /// post
  static Future post({
    required String path,
    required HttpMethod method,
    dynamic data,
    bool showLoading = true,
    bool showErrorMessage = true,
  }) {
    return httpRequest.request(
      path: path,
      method: HttpMethod.post,
      data: data,
      showLoading: showLoading,
      showErrorMessage: showErrorMessage,
    );
  }
}
