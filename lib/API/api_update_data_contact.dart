import 'dart:convert';

import 'package:http/http.dart' as http;

class APIUpdateContact {
  final String? message;
  final String? status;
  APIUpdateContact({this.message, this.status});
  factory APIUpdateContact.createUpdateContact(Map<String, dynamic> json) {
    return APIUpdateContact(message: json['message'], status: json['status']);
  }
  static Future<Map<String, dynamic>> updateHiddenContact(
      String contactId) async {
    String apiUrlGet =
        "http://203.176.177.251/dnc/API/get_contact.php?id=$contactId";
    final http.Response resDataContact = await http.get(Uri.parse(apiUrlGet));
    Map<String, dynamic> body = jsonDecode(resDataContact.body);
    String apiUrlUpdate =
        "http://203.176.177.251/dnc/API/update_contact.php?id=$contactId";
    await http.put(Uri.parse(apiUrlUpdate),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{'id': contactId}));
    if (resDataContact.statusCode == 200) {
      return body;
    } else {
      throw Exception('Failed to update contact.');
    }
  }
}
