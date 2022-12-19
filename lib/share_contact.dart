import 'package:cached_network_image/cached_network_image.dart';
import 'package:digital_business/API/api_get_data_profile.dart';
import 'package:digital_business/component/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: Responsive(
          mobile: shareContact(context, 0.37, 0.60),
          tablet: shareContact(context, 0.20, 0.45),
          desktop: shareContact(context, 0.37, 0.45)),
    );
  }

  Column shareContact(BuildContext context, double sizeLogo, double sizeQR) {
    return Column(children: [
      Flexible(
        flex: 2,
        child: Container(
            margin: const EdgeInsets.only(top: 45, bottom: 12),
            child: Center(
              child: Image(
                width: MediaQuery.of(context).size.width * sizeLogo,
                image: const AssetImage("assets/images/Logos.png"),
              ),
            )),
      ),
      const SizedBox(
        child: Center(
            child: Text(
          "PT. Shield-On Service Tbk",
          style: TextStyle(
              fontSize: 25, fontFamily: "Segoeui", fontWeight: FontWeight.w700),
        )),
      ),
      Flexible(
        flex: 4,
        child: Container(
          margin: const EdgeInsets.all(30),
          child: Center(
              child: (_qrCode != null)
                  ? CachedNetworkImage(
                      width: MediaQuery.of(context).size.width * sizeQR,
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
                  : Shimmer.fromColors(
                      baseColor: const Color.fromARGB(255, 231, 231, 231),
                      highlightColor: const Color.fromARGB(255, 241, 240, 240),
                      child: Container(
                        width: 245,
                        height: 245,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey),
                      ))),
        ),
      ),
      Flexible(
        flex: 1,
        child: (_nama != null)
            ? SizedBox(
                child: Center(
                    child: Text(
                  _nama.toString(),
                  style: const TextStyle(
                      fontSize: 30,
                      fontFamily: "Segoeui",
                      fontWeight: FontWeight.w700),
                )),
              )
            : Shimmer.fromColors(
                baseColor: const Color.fromARGB(255, 231, 231, 231),
                highlightColor: const Color.fromARGB(255, 241, 240, 240),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey),
                )),
      ),
      Flexible(
          flex: 1,
          child: Column(
            children: [
              (_kartuPhone1 != null)
                  ? SizedBox(
                      child: Center(
                          child: Text(
                        _kartuPhone1.toString(),
                        style: const TextStyle(
                            fontSize: 20, fontFamily: "Segoeui"),
                      )),
                    )
                  : Shimmer.fromColors(
                      baseColor: const Color.fromARGB(255, 231, 231, 231),
                      highlightColor: const Color.fromARGB(255, 241, 240, 240),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.38,
                        height: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                      )),
              (_kartuPhone2 != null)
                  ? SizedBox(
                      child: Center(
                          child: Text(
                        _kartuPhone2.toString(),
                        style: const TextStyle(
                            fontSize: 20, fontFamily: "Segoeui"),
                      )),
                    )
                  : Shimmer.fromColors(
                      baseColor: const Color.fromARGB(255, 231, 231, 231),
                      highlightColor: const Color.fromARGB(255, 241, 240, 240),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.38,
                        height: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                      )),
            ],
          )),
      Flexible(
        flex: 1,
        child: (_kartuEmail != null)
            ? SizedBox(
                child: Center(
                    child: Text(
                  _kartuEmail.toString(),
                  style: const TextStyle(fontSize: 20, fontFamily: "Segoeui"),
                )),
              )
            : Shimmer.fromColors(
                baseColor: const Color.fromARGB(255, 231, 231, 231),
                highlightColor: const Color.fromARGB(255, 241, 240, 240),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.42,
                  height: 22,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey),
                )),
      ),
      Flexible(
        flex: 1,
        child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(),
            child: const Text("Kembali")),
      )
    ]);
  }
}
