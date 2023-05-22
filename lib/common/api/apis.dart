import 'package:cookie_jar/cookie_jar.dart';

import 'api_interceptor.dart';
import 'config.dart';

class Api {
  static final CookieJar cookieJar = CookieJar();
}

class Apis {
// 注册
  static Future<dynamic> register({
    required String account,
    required String password,
    required String code,
    required String mobile,
  }) async {
    Map<dynamic, dynamic> response;
    response = (await HttpUtil.post(Urls.register, data: {
      "account": account,
      "password": password,
      "mobile": mobile,
      "code": code
    }));
    return response;
  }

// 获取验证码
  static Future<dynamic> getCode({required mobile}) async {
    Map<String, dynamic> response;
    response =
        await HttpUtil.get(Urls.getCode, queryParameters: {"mobile": mobile});
    return response;
  }

  // 校对验证码
  static Future<dynamic> verifiCode({required mobile, required code}) async {
    Map<String, dynamic> response;

    response = await HttpUtil.post(Urls.verifiCode,
        data: {"mobile": mobile, "code": code});
    return response;
  }

  // 设置新密码
  static Future<dynamic> setNewPwd(
      {required mobile, required password, required code}) async {
    Map<String, dynamic> response;

    response = await HttpUtil.post(Urls.setNewPwd,
        data: {"mobile": mobile, "password": password, "code": code});
    return response;
  }
}
