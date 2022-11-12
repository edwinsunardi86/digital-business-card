import 'package:cached_network_image/cached_network_image.dart';
import 'package:digital_business/API/api_get_data_profile.dart';
import 'package:digital_business/component/dialog_box.dart';
import 'package:digital_business/data_contact.dart';
import 'package:digital_business/login.dart';
import 'package:digital_business/share_contact.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sidebar extends StatefulWidget {
  final String? kartuId;
  const Sidebar({super.key, this.kartuId});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  String? _kartuId;
  String? _fullname;
  String? _foto;
  String? _jabatan;
  String? _email;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  void initial() {
    APIGetDataProfile.fetchDataProfile(widget.kartuId).then((value) {
      setState(() {
        _kartuId = value.kartuId;
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
    bool? isSelected = false;
    return Drawer(
        elevation: 5,
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color.fromARGB(255, 173, 12, 0),
                Color.fromARGB(255, 124, 3, 3)
              ])),
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
                                        "http://203.176.177.251/dnc/dash/pasfoto/$_foto",
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
                                : const Image(
                                    width: 100,
                                    image: NetworkImage(
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScRXe2s0YvgLGalBPBxnFALHraKQwImy3Y7CpaUxA&s")),
                          ),
                          (_fullname != "")
                              ? Text(_fullname.toString(),
                                  style: const TextStyle(
                                      fontFamily: "SourceSansPro",
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))
                              : Text(""),
                          (_jabatan != "")
                              ? Text(_jabatan.toString(),
                                  style: const TextStyle(
                                      fontFamily: "SourceSansPro",
                                      fontSize: 15,
                                      color: Colors.white))
                              : Text(""),
                          (_email != "")
                              ? Text(_email.toString(),
                                  style: const TextStyle(
                                      fontFamily: "SourceSansPro",
                                      fontSize: 15,
                                      color: Colors.white))
                              : Text(""),
                        ])),
                  ),
                  const Divider(
                    thickness: 5,
                  ),
                  Material(
                    elevation: 2,
                    child: ListTile(
                        tileColor: (isSelected == true)
                            ? Colors.white
                            : const Color.fromARGB(255, 189, 27, 16),
                        onTap: () {
                          setState(() {
                            isSelected = true;
                          });
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return ShareContact(kartuId: _kartuId.toString());
                          }));
                        },
                        title: const Text(
                          "Bagikan",
                          style: TextStyle(
                              fontFamily: "SourceSansPro",
                              fontSize: 25,
                              color: Colors.white),
                        )),
                  ),
                  const Divider(
                    thickness: 5,
                  ),
                  Material(
                    elevation: 2,
                    child: ListTile(
                        tileColor: (isSelected == true)
                            ? Colors.white
                            : const Color.fromARGB(255, 189, 27, 16),
                        onTap: () {
                          setState(() {
                            isSelected = true;
                          });
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return const DataContact();
                          }));
                        },
                        title: const Text(
                          "Data Contact",
                          style: TextStyle(
                              fontFamily: "SourceSansPro",
                              fontSize: 25,
                              color: Colors.white),
                        )),
                  )
                ],
              ),
              Material(
                elevation: 2,
                child: ListTile(
                    tileColor: (isSelected == true)
                        ? Colors.white
                        : const Color.fromARGB(255, 189, 27, 16),
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
                                        setState(() {
                                          isSelected = true;
                                        });
                                        if (!mounted) return;
                                        pref.remove("is_login_success");
                                        pref.remove("username");
                                        pref.remove("kartuId");
                                        Navigator.pushReplacement(context,
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
                    title: const Text(
                      "Log Out",
                      style: TextStyle(
                          fontFamily: "SourceSansPro",
                          fontSize: 25,
                          color: Colors.white),
                    )),
              )
            ],
          ),
        ));
  }
}
