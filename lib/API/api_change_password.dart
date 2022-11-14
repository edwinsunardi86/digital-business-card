import 'dart:convert';
import 'package:digital_business/API/url_static.dart';
import 'package:http/http.dart' as http;

class APIChangePassword {
  String? message;
  String? status;

  APIChangePassword({this.message, this.status});
  factory APIChangePassword.createNotification(Map<String, dynamic> json) {
    return APIChangePassword(message: json['message'], status: json['status']);
  }
  static Future<APIChangePassword> fetchNotification(
      String kartuId, String password) async {
    String urlAPI =
        "${UrlAPIStatic.urlAPI()}dnc/API/change_password.php?kartu_id=$kartuId";
    var response = await http.put(Uri.parse(urlAPI),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(
            <String, String>{kartuId: kartuId, 'kartu_pass': password}));
    if (response.statusCode == 200) {
      var jsonObject = jsonDecode(response.body);
      return APIChangePassword.createNotification(jsonObject);
    } else {
      throw 'failed to update password';
    }
  }
}
