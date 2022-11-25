import 'package:cached_network_image/cached_network_image.dart';
import 'package:digital_business/API/api_get_data_profile.dart';
import 'package:digital_business/API/url_static.dart';
import 'package:digital_business/component/my_painter.dart';
import 'package:digital_business/component/responsive.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:digital_business/data_contact.dart';
import 'package:digital_business/share_contact.dart';
import 'package:digital_business/sidebar.dart';
import 'package:flutter/material.dart';
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

  Future<bool> _willPopScope() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Size? size = MediaQuery.of(context).size;
    return SafeArea(
        child: WillPopScope(
      onWillPop: _willPopScope,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          drawer: Sidebar(
            kartuId: _kartuId,
          ),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Responsive(
            mobile: layoutCard(context, size.width * 0.7,
                "assets/images/background_avatar.png", 0),
            tablet: layoutCard(context, size.width * 0.55,
                "assets/images/name_card_digital_samsung_main.jpg", 10),
            desktop: layoutCard(context, size.width * 0.55,
                "assets/images/name_card_digital_samsung_main.jpg", 20),
          )),
    ));
  }

  Container layoutCard(BuildContext context, double sizeWidthPhoto,
      String imageBgUrl, double addFontSize) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(imageBgUrl.toString()), fit: BoxFit.cover)),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (_kartuFoto == null)
                  ? Shimmer.fromColors(
                      baseColor: const Color.fromARGB(255, 231, 231, 231),
                      highlightColor: const Color.fromARGB(255, 241, 240, 240),
                      child: Container(
                        //width: MediaQuery.of(context).size.width * 0.7,
                        // height: 250,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey),
                      ))
                  : CachedNetworkImage(
                      width: sizeWidthPhoto,
                      fit: BoxFit.cover,
                      imageUrl:
                          "${UrlAPIStatic.urlAPI()}dnc/dash/pasfoto/$_kartuFoto",
                      progressIndicatorBuilder: (_, url, download) {
                        if (download.progress != null) {
                          return Shimmer.fromColors(
                              baseColor:
                                  const Color.fromARGB(255, 231, 231, 231),
                              highlightColor:
                                  const Color.fromARGB(255, 241, 240, 240),
                              child: Container(
                                width: 250,
                                height: 250,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.grey),
                              ));
                        } else {
                          return Shimmer.fromColors(
                              baseColor:
                                  const Color.fromARGB(255, 231, 231, 231),
                              highlightColor:
                                  const Color.fromARGB(255, 241, 240, 240),
                              child: Container(
                                  width: 250,
                                  height: 250,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey)));
                        }
                      },
                    ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              (_kartuNama != null)
                  ? Text(_kartuNama.toString(),
                      style: TextStyle(
                          fontFamily: "Segoeui",
                          fontSize: 25 + addFontSize.toDouble(),
                          color: Colors.black,
                          fontWeight: FontWeight.bold))
                  : Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: const Color.fromARGB(255, 192, 192, 192),
                      child: Text("Loading..",
                          style: TextStyle(
                              fontFamily: "Segoeui",
                              fontSize: 25 + addFontSize.toDouble()))),
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
                      height: MediaQuery.of(context).size.height * 0.035,
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
                          child: Center(
                            child: Text(
                              "BAGIKAN",
                              style: TextStyle(
                                fontSize: 13 + addFontSize.toDouble(),
                                fontFamily: "SourceSansPro",
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 145, 5, 5),
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
                      height: MediaQuery.of(context).size.height * 0.035,
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
                          child: Center(
                            child: Text(
                              "LIHAT CONTACT",
                              style: TextStyle(
                                fontSize: 13 + addFontSize.toDouble(),
                                fontFamily: "SourceSansPro",
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 145, 5, 5),
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
    );
  }
}
