class Config {
  // api地址前缀
  static String imApiUrl() {
    return 'https://xxxxxx.xxxxx.com/api/users';
  }
}

// 接口列表
class Urls {
  static var register = "${Config.imApiUrl()}/register";
  static var login = "${Config.imApiUrl()}/login";
  static var getCode = "${Config.imApiUrl()}/getCode";
  static var verifiCode = "${Config.imApiUrl()}/verifiCode";
  static var setNewPwd = "${Config.imApiUrl()}/setNewPwd";
}
