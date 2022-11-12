import 'dart:convert';

import 'package:digital_business/API/url_static.dart';
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
    String urlAPI = "${UrlAPIStatic.urlAPI()}dnc/API/get_contact.php?id=$id";
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
