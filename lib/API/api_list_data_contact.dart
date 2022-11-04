import 'dart:convert';

import 'package:http/http.dart' as http;

class APIListDataContact {
  String? id;
  String? nama;
  String? company;
  String? contactHp;

  APIListDataContact({this.id, this.nama, this.company, this.contactHp});

  factory APIListDataContact.createDataContact(Map<String, dynamic> json) {
    return APIListDataContact(
      id: json['contact_id'],
      nama: json['contact_nama'],
      company: json['company'],
      contactHp: json['contact_hp'],
    );
  }

  static Future<List<APIListDataContact>> fetchDataContact() async {
    String urlAPI =
        "http://203.176.177.251/dnc/API/get_contact_per_username.php";
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
