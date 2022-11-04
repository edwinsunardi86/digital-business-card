import 'dart:convert';

import 'package:http/http.dart' as http;

class APIGetDataContact {
  // final String? message;
  // final String? status;
  final String? contactId;
  final String? nama;
  final String? company;
  final String? contactHp;
  APIGetDataContact({this.contactId, this.nama, this.company, this.contactHp});
  factory APIGetDataContact.createGetDataContact(Map<String, dynamic> json) {
    return APIGetDataContact(
        // message: json['message'],
        // status: json['status'],
        contactId: json['contact_id'],
        nama: json['nama'],
        company: json['company'],
        contactHp: json['contactHp']);
  }
  static Future<APIGetDataContact> fetchDataContact(String id) async {
    String urlAPI = "http://203.176.177.251/dnc/API/get_contact.php?id=$id";
    var response = await http.get(Uri.parse(urlAPI));
    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      var dataContact = jsonObject;
      return APIGetDataContact.createGetDataContact(dataContact);
    } else {
      throw ('failed to get data contact');
    }
  }
}

class APIDeleteContact {
  final String? message;
  final String? status;
  APIDeleteContact({this.message, this.status});
  factory APIDeleteContact.createDeleteContact(Map<String, dynamic> json) {
    return APIDeleteContact(message: json['message'], status: json['status']);
  }
  static Future<Map<String, dynamic>> deleteDataContact(String id) async {
    String apiUrlGet = "http://203.176.177.251/dnc/API/get_contact.php?id=$id";
    final http.Response resDataContact = await http.get(Uri.parse(apiUrlGet));
    Map<String, dynamic> body = jsonDecode(resDataContact.body);
    // print(body);
    //print(body['contact_nama']);

    //return body;
    if (resDataContact.statusCode == 200) {
      String apiUrlDelete =
          "http://203.176.177.251/dnc/API/delete_contact.php?id=$id";
      await http.delete(Uri.parse(apiUrlDelete), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });
      return body;
    } else {
      throw Exception('Failed to delete contact.');
    }
  }
}
