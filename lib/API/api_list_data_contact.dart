import 'dart:convert';

import 'package:digital_business/API/url_static.dart';
import 'package:http/http.dart' as http;

class APIListDataContact {
  String? id;
  String? nama;
  String? company;
  String? kodeDial;
  String? contactHp;

  APIListDataContact(
      {this.id, this.nama, this.company, this.kodeDial, this.contactHp});
  static List<Map<String, dynamic>>? listData;
  factory APIListDataContact.createDataContact(Map<String, dynamic> json) {
    return APIListDataContact(
      id: json['contact_id'],
      nama: json['contact_nama'],
      company: json['company'],
      kodeDial: json['kode_dial'],
      contactHp: json['contact_hp'],
    );
  }

  static Future<List<APIListDataContact>> fetchDataContact(
      String username) async {
    String urlAPI =
        "${UrlAPIStatic.urlAPI()}dnc/API/get_contact_per_username.php?username=$username";
    var response = await http.get(Uri.parse(urlAPI));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<APIListDataContact> dataContact =
          body.map((e) => APIListDataContact.createDataContact(e)).toList();
      return dataContact;
    } else {
      throw "Unable to retrieve data contact";
    }
  }
}
