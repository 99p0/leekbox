class ApiResp {
  int? code;
  String? msg;
  dynamic data;

  ApiResp.fromJson(Map<String, dynamic> map) {
    code = map["code"];
    msg = map["msg"];
    data = map["data"] ?? {};
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['msg'] = msg;
    data['data'] = data;
    return data;
  }
}
