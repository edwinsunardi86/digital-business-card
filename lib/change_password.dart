import 'package:digital_business/API/api_change_password.dart';
import 'package:digital_business/avatar.dart';
import 'package:digital_business/component/dialog_box.dart';
import 'package:digital_business/component/responsive.dart';
import 'package:digital_business/component/text_form_field.dart';
import 'package:digital_business/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  Future<bool> _willPopScope() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return WillPopScope(
      onWillPop: _willPopScope,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: GestureDetector(
              onTap: () {
                return Navigator.of(context).pop();
              },
              child: const Icon(Icons.arrow_back)),
        ),
        body: Responsive(
            mobile: layoutChangePassword(context, 0, 17),
            tablet: layoutChangePassword(context, 30, 25),
            desktop: layoutChangePassword(context, 50, 35)),
      ),
    );
  }

  Widget layoutChangePassword(
      BuildContext context, double addFontSize, double inputFontSize) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.09),
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
          child: Text(
            "Ubah Password",
            style: TextStyle(
                fontFamily: "SourceSansPro",
                fontSize: 30 + addFontSize.toDouble(),
                fontWeight: FontWeight.bold),
          ),
        ),
        Form(
            key: _formKey,
            child: Column(children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  margin: const EdgeInsets.all(25),
                  child: TextFormFieldVarian1(
                      fontSize: inputFontSize,
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
                  height: MediaQuery.of(context).size.height * 0.05,
                  margin: const EdgeInsets.all(25),
                  child: TextFormFieldVarian1(
                      fontSize: inputFontSize,
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
                                          return const AvatarCard();
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
                  icon: const Icon(Icons.key),
                  label: Text(
                    "Change Password",
                    style: TextStyle(
                        fontFamily: "SourceSansPro",
                        fontSize: inputFontSize.toDouble()),
                  ))
            ]))
      ],
    );
  }
}
