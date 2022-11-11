import 'dart:convert';

import 'package:http/http.dart' as http;

class APIGetDataProfile {
  String? kartuId;
  String? kartuFoto;
  String? kartuNama;
  String? kartuJabatan;
  String? kartuPhone1;
  String? kartuPhone2;
  String? kartuQrCode;
  String? kartuEmail;
  APIGetDataProfile(
      {this.kartuId,
      this.kartuFoto,
      this.kartuNama,
      this.kartuJabatan,
      this.kartuPhone1,
      this.kartuPhone2,
      this.kartuQrCode,
      this.kartuEmail});

  factory APIGetDataProfile.createDataProfile(Map<String, dynamic> json) {
    return APIGetDataProfile(
        kartuId: json['kartu_id'],
        kartuFoto: json['kartu_foto'],
        kartuNama: json['kartu_nama'],
        kartuJabatan: json['kartu_jabatan'],
        kartuPhone1: json['kartu_phone1'],
        kartuPhone2: json['kartu_phone2'],
        kartuQrCode: json['kartu_qr_code'],
        kartuEmail: json['kartu_email']);
  }

  static Future<APIGetDataProfile> fetchDataProfile(kartuId) async {
    String apiUrl =
        "http://203.176.177.251/dnc/API/get_profile_user.php?kartu_id=$kartuId";
    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var jsonObject = jsonDecode(response.body);
      return APIGetDataProfile.createDataProfile(jsonObject);
    } else {
      throw ('failed to get data profil');
    }
  }
}
