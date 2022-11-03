import 'package:http/http.dart' as http;

Future<http.Response> deleteDataContact(String id) async {
  String apiUrl = "http://203.176.177.251/API/delete_contact.php?id=$id";
  final http.Response response = await http.delete(Uri.parse(apiUrl),
      headers: <String, String>{'Content': 'application/json;charset=UTF-8'});
  return response;
}
