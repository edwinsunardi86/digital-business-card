import 'package:cached_network_image/cached_network_image.dart';
import 'package:digital_business/API/api_get_data_profile.dart';
import 'package:digital_business/API/url_static.dart';
import 'package:digital_business/component/my_painter.dart';
import 'package:digital_business/component/shimmer.dart';
import 'package:digital_business/component/shimmer_loading.dart';
// import 'package:shimmer/shimmer.dart';
import 'package:digital_business/data_contact.dart';
import 'package:digital_business/share_contact.dart';
import 'package:digital_business/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvatarCard extends StatefulWidget {
  const AvatarCard({super.key});

  @override
  State<AvatarCard> createState() => _AvatarCardState();
}

class _AvatarCardState extends State<AvatarCard> {
  String? _kartuId;
  String? _kartuFoto;
  String? _kartuNama;
  String? _kartuJabatan;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  void getProfil() async {
    final SharedPreferences pref = await _prefs;
    String kartuId = pref.getString("kartuId").toString();
    await APIGetDataProfile.fetchDataProfile(kartuId).then((value) {
      setState(() {
        _kartuId = value.kartuId.toString();
        _kartuFoto = value.kartuFoto.toString();
        _kartuNama = value.kartuNama.toString();
        _kartuJabatan = value.kartuJabatan.toString();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getProfil();
  }

  @override
  Widget build(BuildContext context) {
    const shimmerGradient = LinearGradient(
      colors: [
        Color(0xFFEBEBF4),
        Color.fromARGB(255, 194, 193, 193),
        Color(0xFFEBEBF4),
      ],
      stops: [
        0.1,
        0.3,
        0.4,
      ],
      begin: Alignment(-1.0, -0.3),
      end: Alignment(1.0, 0.3),
      tileMode: TileMode.clamp,
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background_avatar.png"),
                fit: BoxFit.cover)),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          drawer: Sidebar(
            kartuId: _kartuId,
          ),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.15,
                        left: MediaQuery.of(context).size.width * 0.15,
                        right: MediaQuery.of(context).size.width * 0.15),
                    child: (_kartuFoto == null)
                        ? Container(
                            width: MediaQuery.of(context).size.width * 0.55,
                            height: MediaQuery.of(context).size.width * 0.55,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: const Image(
                                image: AssetImage(
                                    "assets/images/Avatar-Profile.png")),
                          )
                        : CachedNetworkImage(
                            width: MediaQuery.of(context).size.width * 0.7,
                            fit: BoxFit.cover,
                            imageUrl:
                                "${UrlAPIStatic.urlAPI()}dnc/dash/pasfoto/$_kartuFoto",
                            progressIndicatorBuilder: (_, url, download) {
                              if (download.progress != null) {
                                final percent = download.progress! * 100;
                                return Text("$percent% done loading");
                              } else {
                                return const CircularProgressIndicator(
                                  color: Colors.white,
                                );
                              }
                            },
                          ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  (_kartuNama != null)
                      ? Text(_kartuNama.toString(),
                          style: const TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold))
                      : const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                  const SizedBox(
                    height: 25,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                        color: Colors.transparent,
                        elevation: 0,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.30,
                          height: 35,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ShareContact(kartuId: _kartuId),
                                  ));
                            },
                            splashColor: Colors.white,
                            child: CustomPaint(
                              painter: MyPainter(),
                              child: const Center(
                                child: Text(
                                  "BAGIKAN",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: "SourceSansPro",
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 145, 5, 5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Material(
                        color: Colors.transparent,
                        elevation: 0,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.30,
                          height: 35,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const DataContact(),
                                  ));
                            },
                            splashColor: Colors.white,
                            child: CustomPaint(
                              painter: MyPainter(),
                              child: const Center(
                                child: Text(
                                  "LIHAT CONTACT",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: "SourceSansPro",
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 145, 5, 5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
