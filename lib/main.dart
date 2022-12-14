import 'package:digital_business/avatar.dart';
import 'package:digital_business/example_dialog.dart';
import 'package:digital_business/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences? loginData;
  bool? isLoginSuccess;

  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      isLoginSuccess = loginData!.getBool("is_login_success") ?? false;
      // print(loginData!.getBool("is_login_success") ?? false);
    });
  }

  @override
  void initState() {
    super.initState();
    initial();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        //home: const LoginApps());
        // home: const MyDialogAlert());
        home:
            (isLoginSuccess == true) ? const AvatarCard() : const LoginApps());
  }
}
