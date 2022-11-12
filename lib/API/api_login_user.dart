import 'dart:convert';
import 'package:digital_business/API/url_static.dart';
import 'package:http/http.dart' as http;

class ApiLogin {
  String? message;
  String? status;
  String? kartuId;
  String? token;

  ApiLogin({
    this.message,
    this.status,
    this.kartuId,
    this.token,
  });
  factory ApiLogin.createNotificationAuthentication(Map<String, dynamic> json) {
    return ApiLogin(
      message: json['message'],
      status: json['status'],
      kartuId: json['kartu_id'],
      token: json['token'],
    );
  }
  static Future<ApiLogin> fetchNotificationAuthentication(
      String username, String password) async {
    String apiUrl =
        "${UrlAPIStatic.urlAPI()}dnc/API/get_authentication_login.php";
    var response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-type': 'application/json',
        },
        body: json.encode(<String, String>{
          'username': username.toString(),
          'password': password.toString()
        }));
    if (response.statusCode == 200) {
      var jsonObject = jsonDecode(response.body);
      return ApiLogin.createNotificationAuthentication(jsonObject);
    } else {
      throw 'failed to get authentication';
    }
  }
}
