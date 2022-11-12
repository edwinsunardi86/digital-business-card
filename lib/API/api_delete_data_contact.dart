import 'dart:convert';

import 'package:digital_business/API/url_static.dart';
import 'package:http/http.dart' as http;

class APIDeleteContact {
  final String? message;
  final String? status;
  APIDeleteContact({this.message, this.status});
  factory APIDeleteContact.createDeleteContact(Map<String, dynamic> json) {
    return APIDeleteContact(message: json['message'], status: json['status']);
  }
  static Future<Map<String, dynamic>> deleteDataContact(String id) async {
    String apiUrlGet = "${UrlAPIStatic.urlAPI()}dnc/API/get_contact.php?id=$id";
    final http.Response resDataContact = await http.get(Uri.parse(apiUrlGet));
    Map<String, dynamic> body = jsonDecode(resDataContact.body);
    // print(body);
    //print(body['contact_nama']);

    //return body;
    if (resDataContact.statusCode == 200) {
      String apiUrlDelete =
          "${UrlAPIStatic.urlAPI()}dnc/API/delete_contact.php?id=$id";
      await http.delete(Uri.parse(apiUrlDelete), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });
      return body;
    } else {
      throw Exception('Failed to delete contact.');
    }
  }
}
