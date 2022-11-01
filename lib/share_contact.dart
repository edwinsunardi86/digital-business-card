import 'package:flutter/material.dart';

class ShareContact extends StatelessWidget {
  const ShareContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
            margin: const EdgeInsets.all(30),
            child: Center(
              child: Image(
                width: MediaQuery.of(context).size.width * 0.60,
                image: const AssetImage("assets/images/Logos.png"),
              ),
            )),
        const SizedBox(
          child: Center(
              child: Text(
            "PT. Shield-On Service Tbk",
            style: TextStyle(
                fontSize: 30,
                fontFamily: "PTSerif",
                fontWeight: FontWeight.w700),
          )),
        ),
        Container(
            margin: const EdgeInsets.all(30),
            child: Center(
              child: Image(
                width: MediaQuery.of(context).size.width * 0.60,
                image: const AssetImage(
                    "assets/images/qr/1831035087_Herman Julianto.png"),
              ),
            )),
        const SizedBox(
          child: Center(
              child: Text(
            "Herman Julianto",
            style: TextStyle(
                fontSize: 30,
                fontFamily: "PTSerif",
                fontWeight: FontWeight.w700),
          )),
        ),
        const SizedBox(
          height: 20,
        ),
        const SizedBox(
          child: Center(
              child: Text(
            "+6285 888 000 555",
            style: TextStyle(fontSize: 25, fontFamily: "PTSerif"),
          )),
        ),
        const SizedBox(
          child: Center(
              child: Text(
            "+628 12345 12345",
            style: TextStyle(fontSize: 25, fontFamily: "PTSerif"),
          )),
        ),
        const SizedBox(
          height: 20,
        ),
        const SizedBox(
          child: Center(
              child: Text(
            "hmjulianto@sos.co.id",
            style: TextStyle(fontSize: 25, fontFamily: "PTSerif"),
          )),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(),
            child: const Text("Kembali"))
      ]),
    );
  }
}
