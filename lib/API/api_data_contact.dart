import 'dart:convert';

import 'package:http/http.dart' as http;

class APIDataContact {
  String? nama;
  String? company;
  String? contactHp;

  APIDataContact({this.nama, this.company, this.contactHp});

  factory APIDataContact.createDataContact(Map<String, dynamic> json) {
    return APIDataContact(
      nama: json['contact_nama'],
      company: json['company'],
      contactHp: json['contact_hp'],
    );
  }

  static Future<List<APIDataContact>> fetchDataContact() async {
    String urlAPI =
        "http://203.176.177.251/dnc/API/get_contact_per_username.php";
    var response = await http.get(Uri.parse(urlAPI));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<APIDataContact> dataContact =
          body.map((e) => APIDataContact.createDataContact(e)).toList();
      return dataContact;
    } else {
      throw "Unable to retrieve data contact";
    }
  }
}
