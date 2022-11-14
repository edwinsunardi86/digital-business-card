import 'package:flutter/material.dart';
import 'package:digital_business/API/api_login_user.dart';
import 'package:digital_business/avatar.dart';
import 'package:digital_business/component/dialog_box.dart';
import 'package:digital_business/component/custom_shape.dart';
import 'package:digital_business/component/text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginApps extends StatefulWidget {
  const LoginApps({super.key});

  @override
  State<LoginApps> createState() => _LoginAppsState();
}

class _LoginAppsState extends State<LoginApps> {
  ApiLogin? apiLogin = ApiLogin();
  final _formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool? autofocus = true;
  late FocusNode focusNode;
  Color? textColor;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool? isLoginSuccess;
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  void disposed() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 25),
                      child: const Image(
                        image: AssetImage("assets/images/Logos.png"),
                        width: 150,
                      ),
                    ),
                    const Text(
                      "Digital Business Card",
                      style: TextStyle(
                          fontFamily: "SourceSansPro",
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 25),
                    const Text("Login",
                        style: TextStyle(
                            fontFamily: "SourceSansPro",
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                    Container(
                        margin: const EdgeInsets.all(25),
                        child: TextFormFieldVarian1(
                            labelText: "Username",
                            controller: username,
                            autofocus: autofocus,
                            focusNode: focusNode,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Mohon input username anda';
                              }
                              return null;
                            },
                            prefixIcon: const Icon(Icons.person),
                            obscureText: false)),
                    Container(
                        margin: const EdgeInsets.all(25),
                        child: TextFormFieldVarian1(
                            labelText: "Password",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Mohon input password anda';
                              }
                              return null;
                            },
                            controller: password,
                            prefixIcon: const Icon(Icons.key),
                            obscureText: true)),
                    Ink(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromARGB(255, 173, 12, 0),
                                Color.fromARGB(255, 124, 3, 3)
                              ])),
                      width: 200,
                      height: 50,
                      child: InkWell(
                        onTap: () async {
                          final SharedPreferences pref = await _prefs;
                          if (_formKey.currentState!.validate()) {
                            try {
                              var req = await ApiLogin
                                  .fetchNotificationAuthentication(
                                      username.text, password.text);
                              if (req.status == "success") {
                                setState(() {
                                  isLoginSuccess = true;
                                });
                                pref.setBool(
                                    "is_login_success", isLoginSuccess!);

                                pref.setString("username", username.text);
                                pref.setString(
                                    "kartuId", req.kartuId.toString());
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return DialogBox(
                                          title: "Perhatian",
                                          description: "Login anda berhasil!",
                                          action: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton.icon(
                                                onPressed: () {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const AvatarCard()));
                                                },
                                                icon:
                                                    const Icon(Icons.thumb_up),
                                                label: const Text(
                                                  "OKE!",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "SourceSansPro"),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.green),
                                              )
                                            ],
                                          ));
                                    });
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return DialogBox(
                                          title: "Perhatian",
                                          description:
                                              "Silahkan login ulang kembali.",
                                          action: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton.icon(
                                                onPressed: () {
                                                  focusNode.requestFocus();
                                                  Navigator.of(context).pop();
                                                  setState(() {
                                                    username.text = "";
                                                    password.text = "";
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.login,
                                                  color: Colors.black,
                                                ),
                                                label: const Text(
                                                  "Login Ulang",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "SourceSansPro",
                                                      color: Colors.black),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white),
                                              )
                                            ],
                                          ));
                                    });
                              }
                            } on Exception {}
                          }
                        },
                        borderRadius: BorderRadius.circular(25),
                        splashColor: Colors.white,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.login,
                                color: Colors.white,
                              ),
                              Text(
                                "Submit",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "SourceSansPro"),
                              )
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ClipPath(
                  clipper: CustomShape(),
                  child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                          Color.fromARGB(255, 173, 12, 0),
                          Color.fromARGB(255, 124, 3, 3)
                        ])),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: null,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
