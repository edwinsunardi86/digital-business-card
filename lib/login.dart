import 'package:digital_business/API/api_login_user.dart';
import 'package:flutter/material.dart';
import 'package:digital_business/component/custom_shape.dart';
import 'package:digital_business/component/text_form_field.dart';

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
  Color? textColor;
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Mohon input username anda';
                              }
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
                            },
                            controller: password,
                            prefixIcon: const Icon(Icons.password),
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
                          if (_formKey.currentState!.validate()) {
                            try {
                              var req = await ApiLogin
                                  .fetchNotificationAuthentication(
                                      username.text, password.text);
                              if (req.status.toString() == "success") {}
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
