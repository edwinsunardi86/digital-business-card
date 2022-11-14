import 'package:digital_business/API/api_change_password.dart';
import 'package:digital_business/avatar.dart';
import 'package:digital_business/component/dialog_box.dart';
import 'package:digital_business/component/text_form_field.dart';
import 'package:digital_business/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController password = TextEditingController();
  TextEditingController repassword = TextEditingController();
  String? _kartuId;
  final _formKey = GlobalKey<FormState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  void initial() async {
    final SharedPreferences pref = await _prefs;
    String kartuId = pref.getString("kartuId").toString();
    setState(() {
      _kartuId = kartuId;
    });
  }

  @override
  void initState() {
    super.initState();
    initial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Container(
              margin: const EdgeInsets.all(30),
              child: Center(
                child: Image(
                  width: MediaQuery.of(context).size.width * 0.30,
                  image: const AssetImage("assets/images/Logos.png"),
                ),
              )),
          Container(
            margin: const EdgeInsets.only(top: 15, bottom: 30),
            child: const Text(
              "Ubah Password",
              style: TextStyle(
                  fontFamily: "SourceSansPro",
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Form(
              key: _formKey,
              child: Column(children: [
                Container(
                    height: 50,
                    margin: const EdgeInsets.all(25),
                    child: TextFormFieldVarian1(
                        labelText: "Password Baru",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Mohon input password anda';
                          }
                          return null;
                        },
                        controller: password,
                        prefixIcon: const Icon(Icons.key),
                        obscureText: true)),
                Container(
                    height: 50,
                    margin: const EdgeInsets.all(25),
                    child: TextFormFieldVarian1(
                        labelText: "Ulangi password",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Mohon input re-password anda';
                          } else if (value != password.text) {
                            return 'Harus sama dengan input password';
                          }
                          return null;
                        },
                        controller: repassword,
                        prefixIcon: const Icon(Icons.key),
                        obscureText: true)),
                ElevatedButton.icon(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await APIChangePassword.fetchNotification(
                                _kartuId.toString(), password.text)
                            .then((value) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return DialogBox(
                                    title: "Perhatian",
                                    description: value.message,
                                    action: ElevatedButton.icon(
                                        onPressed: () {
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return AvatarCard();
                                          }));
                                        },
                                        icon: const Icon(Icons.route),
                                        label: const Text("OK",
                                            style: TextStyle(
                                                fontFamily: "SourceSansPro"))));
                              });
                        });
                      }
                    },
                    icon: const Icon(Icons.password),
                    label: const Text(
                      "Change Password",
                      style: TextStyle(fontFamily: "SourceSansPro"),
                    ))
              ]))
        ],
      ),
    );
  }
}
