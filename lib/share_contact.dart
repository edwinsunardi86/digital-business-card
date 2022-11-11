import 'package:cached_network_image/cached_network_image.dart';
import 'package:digital_business/API/api_get_data_profile.dart';
import 'package:flutter/material.dart';

class ShareContact extends StatefulWidget {
  final String? kartuId;

  const ShareContact({super.key, this.kartuId});

  @override
  State<ShareContact> createState() => _ShareContactState();
}

class _ShareContactState extends State<ShareContact> {
  String? _nama;
  String? _qrCode;
  String? _kartuPhone1;
  String? _kartuPhone2;
  String? _kartuEmail;
  void getProfil() async {
    await APIGetDataProfile.fetchDataProfile(widget.kartuId).then((value) {
      setState(() {
        _nama = value.kartuNama;
        _qrCode = value.kartuQrCode;
        _kartuPhone1 = value.kartuPhone1;
        _kartuPhone2 = value.kartuPhone2;
        _kartuEmail = value.kartuEmail;
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
    return Scaffold(
      body: Column(children: [
        Container(
            margin: const EdgeInsets.only(top: 45, bottom: 12),
            child: Center(
              child: Image(
                width: MediaQuery.of(context).size.width * 0.37,
                image: const AssetImage("assets/images/Logos.png"),
              ),
            )),
        const SizedBox(
          child: Center(
              child: Text(
            "PT. Shield-On Service Tbk",
            style: TextStyle(
                fontSize: 25,
                fontFamily: "Segoeui",
                fontWeight: FontWeight.w700),
          )),
        ),
        Container(
          margin: const EdgeInsets.all(30),
          child: Center(
              child: (_qrCode != null)
                  ? CachedNetworkImage(
                      width: MediaQuery.of(context).size.width * 0.60,
                      imageUrl: "http://203.176.177.251/dnc/dash/qr/$_qrCode",
                      progressIndicatorBuilder: (context, url, download) {
                        if (download.progress != null) {
                          final double percent = download.progress! * 100;
                          return Text("$percent% done loading");
                        } else {
                          return const CircularProgressIndicator(
                            color: Colors.white,
                          );
                        }
                      },
                    )
                  : const Image(
                      image: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScRXe2s0YvgLGalBPBxnFALHraKQwImy3Y7CpaUxA&s"))),
        ),
        SizedBox(
          child: Center(
              child: Text(
            _nama.toString(),
            style: const TextStyle(
                fontSize: 30,
                fontFamily: "Segoeui",
                fontWeight: FontWeight.w700),
          )),
        ),
        const SizedBox(
          height: 20,
        ),
        (_kartuPhone1 != null)
            ? SizedBox(
                child: Center(
                    child: Text(
                  _kartuPhone1.toString(),
                  style: const TextStyle(fontSize: 20, fontFamily: "Segoeui"),
                )),
              )
            : const Text(""),
        (_kartuPhone2 != null)
            ? SizedBox(
                child: Center(
                    child: Text(
                  _kartuPhone2.toString(),
                  style: const TextStyle(fontSize: 20, fontFamily: "Segoeui"),
                )),
              )
            : const Text(""),
        const SizedBox(
          height: 20,
        ),
        (_kartuEmail != null)
            ? SizedBox(
                child: Center(
                    child: Text(
                  _kartuEmail.toString(),
                  style: const TextStyle(fontSize: 20, fontFamily: "Segoeui"),
                )),
              )
            : Text(""),
        const SizedBox(height: 30),
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
