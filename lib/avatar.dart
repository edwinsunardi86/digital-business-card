import 'package:digital_business/component/my_painter.dart';
import 'package:digital_business/share_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AvatarCard extends StatefulWidget {
  const AvatarCard({super.key});

  @override
  State<AvatarCard> createState() => _AvatarCardState();
}

class _AvatarCardState extends State<AvatarCard> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: Stack(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
              child: const Image(
                image: AssetImage("assets/images/background_avatar.png"),
                fit: BoxFit.cover,
              )),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.22,
                    left: MediaQuery.of(context).size.width * 0.15,
                    right: MediaQuery.of(context).size.width * 0.15),
                width: MediaQuery.of(context).size.width * 0.7,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: const Image(
                      image: AssetImage(
                          "assets/images/2021254138_FOTO PAK HJ_PNG.png"),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Herman Julianto",
                  style: TextStyle(fontSize: 25, color: Colors.black)),
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
                                builder: (context) => const ShareContact(),
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
                        onTap: () {},
                        splashColor: Colors.white,
                        child: CustomPaint(
                          painter: MyPainter(),
                          child: const Center(
                            child: Text(
                              "LIHAT KONTAK",
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
          )
        ],
      ),
    );
  }
}
