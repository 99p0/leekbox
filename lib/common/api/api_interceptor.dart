import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'api_resp.dart';
import 'apis.dart';
import 'config.dart';

Dio dio = Dio();

class HttpUtil {
  HttpUtil._();

  static void init() {
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      return handler.next(options);
    }, onResponse: (response, handler) {
      return handler.next(response);
    }, onError: (DioError e, handler) {
      return handler.next(e);
    }));

    dio.interceptors.add(CookieManager(Api.cookieJar));

    // 配置dio实例
    dio.options.baseUrl = Config.imApiUrl();
    dio.options.connectTimeout = const Duration(milliseconds: 30000);
    dio.options.receiveTimeout = const Duration(milliseconds: 30000);
  }

  // post 请求
  static Future<Map<String, dynamic>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var result = await dio.post<Map<String, dynamic>>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      print(result);
      var resp = ApiResp.fromJson(result.data!);

      // 成功返回
      if (resp.code == 0) {
        var response = {"data": resp.data, "code": resp.code, "msg": resp.msg};
        return response;
      } else {
        // 业务报错
        return Future.error((resp.msg).toString());
      }
    } catch (error) {
      // 网络报错
      if (error is DioError) {
      } else {}
      return Future.error(error);
    }
  }

  // get请求
  static Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var result = await dio.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      var resp = ApiResp.fromJson(result.data!);
      // 成功返回
      if (resp.code == 0) {
        var response = {
          "data": resp.data ?? {},
          "code": resp.code,
          "msg": resp.msg
        };
        return response;
      } else {
        // 业务报错
        return Future.error(resp);
      }
    } catch (error) {
      // 网络报错
      if (error is DioError) {
      } else {}
      return Future.error(error);
    }
  }
}
