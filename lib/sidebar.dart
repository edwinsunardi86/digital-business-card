import 'package:cached_network_image/cached_network_image.dart';
import 'package:digital_business/API/api_get_data_profile.dart';
import 'package:digital_business/API/url_static.dart';
import 'package:digital_business/change_password.dart';
import 'package:digital_business/component/dialog_box.dart';
import 'package:digital_business/component/responsive.dart';
import 'package:digital_business/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class Sidebar extends StatefulWidget {
  final String? kartuId;
  const Sidebar({super.key, this.kartuId});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  String? _fullname;
  String? _foto;
  String? _jabatan;
  String? _email;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  void initial() {
    APIGetDataProfile.fetchDataProfile(widget.kartuId).then((value) {
      setState(() {
        _fullname = value.kartuNama;
        _foto = value.kartuFoto;
        _jabatan = value.kartuJabatan;
        _email = value.kartuEmail;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initial();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: responsiveSidebar(context, 0.45, 0),
        tablet: responsiveSidebar(context, 0.45, 10),
        desktop: responsiveSidebar(context, 0.45, 20));
  }

  Drawer responsiveSidebar(
      BuildContext context, double sizeWidth, double addFontSize) {
    return Drawer(
        width: MediaQuery.of(context).size.width * sizeWidth,
        elevation: 5,
        backgroundColor: const Color.fromARGB(200, 255, 255, 255),
        child: Container(
          decoration: const BoxDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  Material(
                    elevation: 5,
                    child: Container(
                        padding: const EdgeInsets.only(top: 25, bottom: 25),
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                              Color.fromARGB(255, 173, 12, 0),
                              Color.fromARGB(255, 124, 3, 3)
                            ])),
                        child: Column(children: [
                          ClipRRect(
                              child: (_foto != null)
                                  ? CachedNetworkImage(
                                      width: 100,
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          "${UrlAPIStatic.urlAPI()}dnc/dash/pasfoto/$_foto",
                                      progressIndicatorBuilder:
                                          (_, url, download) {
                                        if (download.progress != null) {
                                          final percent =
                                              download.progress! * 100;
                                          return Text("$percent% done loading");
                                        } else {
                                          return const CircularProgressIndicator(
                                            color: Colors.white,
                                          );
                                        }
                                      },
                                    )
                                  : Shimmer.fromColors(
                                      baseColor: const Color.fromARGB(
                                          255, 223, 223, 223),
                                      highlightColor: const Color.fromARGB(
                                          255, 235, 235, 235),
                                      child: Container(
                                          width: 85,
                                          height: 85,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white)))),
                          const SizedBox(height: 10),
                          (_fullname != null)
                              ? Text(_fullname.toString(),
                                  style: TextStyle(
                                      fontFamily: "Segoeui",
                                      fontSize: 17 + addFontSize.toDouble(),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))
                              : Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(255, 223, 223, 223),
                                  highlightColor:
                                      const Color.fromARGB(255, 235, 235, 235),
                                  child: Container(
                                      width: 90,
                                      height: 15,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Colors.white))),
                          const SizedBox(height: 10),
                          (_jabatan != null)
                              ? Text(_jabatan.toString(),
                                  style: TextStyle(
                                      fontFamily: "Segoeui",
                                      fontSize: 11 + addFontSize.toDouble(),
                                      color: Colors.white))
                              : Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(255, 223, 223, 223),
                                  highlightColor:
                                      const Color.fromARGB(255, 235, 235, 235),
                                  child: Container(
                                      width: 80,
                                      height: 15,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Colors.white))),
                          const SizedBox(height: 10),
                          (_email != null)
                              ? Text(_email.toString(),
                                  style: TextStyle(
                                      fontFamily: "Segoeui",
                                      fontSize: 11 + addFontSize.toDouble(),
                                      color: Colors.white))
                              : Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(255, 223, 223, 223),
                                  highlightColor:
                                      const Color.fromARGB(255, 235, 235, 235),
                                  child: Container(
                                      width: 80,
                                      height: 15,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Colors.white))),
                        ])),
                  ),
                  const SizedBox(height: 5),
                  ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const ChangePassword())));
                      },
                      title: Row(
                        children: [
                          const Icon(Icons.key),
                          const SizedBox(width: 5),
                          Text(
                            "Ubah Password",
                            style: TextStyle(
                              fontFamily: "Segoeui",
                              fontSize: 15 + addFontSize.toDouble(),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
              Column(
                children: [
                  const Divider(
                    thickness: 1,
                  ),
                  ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return DialogBox(
                                  title: "Perhatian",
                                  description:
                                      "Apakah anda benar-benar ingin log out?",
                                  action: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () async {
                                          final SharedPreferences pref =
                                              await _prefs;
                                          if (!mounted) return;
                                          pref.remove("is_login_success");
                                          pref.remove("username");
                                          pref.remove("kartuId");
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (_) {
                                            return const LoginApps();
                                          }));
                                        },
                                        icon: const Icon(
                                          Icons.logout,
                                        ),
                                        label: const Text("Log Out",
                                            style: TextStyle(
                                                fontFamily: "SourceSansPro")),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red),
                                      ),
                                      const SizedBox(width: 25),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          return Navigator.of(context).pop();
                                        },
                                        icon: const Icon(
                                          Icons.cancel,
                                          color: Colors.black,
                                        ),
                                        label: const Text("Cancel",
                                            style: TextStyle(
                                                fontFamily: "SourceSansPro",
                                                color: Colors.black)),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white),
                                      )
                                    ],
                                  ));
                            });
                      },
                      title: Row(
                        children: [
                          const Icon(Icons.logout),
                          const SizedBox(width: 5),
                          Text(
                            "Log Out",
                            style: TextStyle(
                              fontFamily: "Segoeui",
                              fontSize: 15 + addFontSize.toDouble(),
                            ),
                          ),
                        ],
                      )),
                ],
              )
            ],
          ),
        ));
  }
}
