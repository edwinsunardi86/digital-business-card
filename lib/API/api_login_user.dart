import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiLogin {
  String? message;
  String? status;
  String? token;
  ApiLogin({this.message, this.status, this.token});
  factory ApiLogin.createNotificationAuthentication(Map<String, String> json) {
    return ApiLogin(
        message: json['message'], status: json['status'], token: json['token']);
  }
  static Future<ApiLogin> fetchNotificationAuthentication(
      String username, String password) async {
    String apiUrl = "http://203.176.177.251/dnc/API/login_user.http";
    var response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(
            <String, dynamic>{'username': username, 'password': password}));
    if (response.statusCode == 200) {
      var jsonObject = jsonDecode(response.body);
      return ApiLogin.createNotificationAuthentication(jsonObject);
    } else {
      throw 'failed to get authentication';
    }
  }
}
