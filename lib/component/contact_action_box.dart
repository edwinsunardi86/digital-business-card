import 'dart:io';

import 'package:digital_business/component/custom_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:digital_business/API/api_delete_data_contact.dart';
import 'package:digital_business/data_contact.dart';

import 'dialog_box.dart';

class ConstantsValue {
  ConstantsValue._();
  static const double paddingVal = 20;
  static const double iconValue = 45;
}

class ContactActionBox extends StatelessWidget {
  final String? id;
  final String? nama;
  final String? company;
  final String? contactHP;
  const ContactActionBox(
      {super.key, this.id, this.nama, this.company, this.contactHP});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      elevation: 5,
      child: contentBox(context),
      backgroundColor: Colors.transparent,
    );
  }

  contentBox(context) {
    return Stack(children: [_container(context), _positioned(context)]);
  }

  Container _container(context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(
            ConstantsValue.paddingVal,
            ConstantsValue.paddingVal * 3 + ConstantsValue.iconValue,
            ConstantsValue.paddingVal,
            ConstantsValue.paddingVal),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: const Color.fromARGB(255, 65, 4, 0),
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black, offset: Offset(0, 10), blurRadius: 10)
            ]),
        child: Card(
          elevation: 5,
          child: Container(
            padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nama: $nama",
                    textAlign: TextAlign.left,
                    maxLines: 5,
                    style: const TextStyle(
                        fontFamily: "SourceSansPro",
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Divider(
                  height: 2,
                  color: Colors.grey,
                ),
                const SizedBox(height: 10),
                Text("Company: $company",
                    maxLines: 5,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontFamily: "SourceSansPro",
                      fontSize: 20,
                    )),
                const SizedBox(height: 10),
                const Divider(
                  height: 2,
                  color: Colors.grey,
                ),
                const SizedBox(height: 10),
                Text(
                  "contact: $contactHP",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontFamily: "SourceSansPro", fontSize: 20),
                ),
                const SizedBox(height: 10),
                const Divider(
                  height: 2,
                  color: Colors.grey,
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return DialogBox(
                                title: "Hapus Data $nama",
                                description:
                                    "Apakah anda ingin menghapus data contact $nama?",
                                action: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton.icon(
                                          onPressed: () {
                                            APIDeleteContact.deleteDataContact(
                                                    id.toString())
                                                .then((value) {
                                              //print(value['contact_nama']);
                                              showDialog(
                                                  context: context,
                                                  builder: ((context) =>
                                                      DialogBox(
                                                        title: "Perhatian!",
                                                        description:
                                                            // ignore: prefer_interpolation_to_compose_strings
                                                            "${"Data kontak dengan nama " + value['contact_nama']} berhasil dihapus",
                                                        action:
                                                            ElevatedButton.icon(
                                                                onPressed: () {
                                                                  // Navigator.of(
                                                                  //         context)
                                                                  //     .pop();
                                                                  Navigator.pushReplacement(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder:
                                                                              (context) {
                                                                    return const DataContact();
                                                                  }));
                                                                },
                                                                icon: const Icon(
                                                                    Icons
                                                                        .close),
                                                                label: const Text(
                                                                    "Tutup",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontFamily:
                                                                            "SourceSansPro"))),
                                                      )));
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                          label: const Text(
                                            "Hapus",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "SourceSansPro"),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red)),
                                      ElevatedButton.icon(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          icon: const Icon(Icons.cancel,
                                              color: Colors.white),
                                          label: const Text("Batal",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "SourceSansPro")))
                                    ]));
                          });

                      // FutureBuilder<APIGetDataContact>(
                      //     future: deleteDataContact(id.toString()),
                      //     builder: (context,
                      //         AsyncSnapshot<APIGetDataContact> snapshot) {
                      //       if (snapshot.hasData) {
                      //         APIGetDataContact? getDataContact = snapshot.data;
                      //         showDialog(
                      //             context: context,
                      //             builder: (context) {
                      //               return CustomDialogBox(
                      //                   title: "Perhatian",
                      //                   description: getDataContact!.message);
                      //             });
                      //       } else {
                      //         return Text("");
                      //       }
                      //     });
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text("Hapus",
                        style: TextStyle(
                            fontFamily: "SourceSansPro", fontSize: 15)),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red)),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (await FlutterContacts.requestPermission()) {
                      final Contact newContact = Contact();
                      newContact.name = Name(nickname: nama.toString());
                      newContact.organizations = [
                        Organization(company: company.toString())
                      ];
                      newContact.phones = [Phone(contactHP.toString())];
                      await newContact.insert();

                      showDialog(
                          context: context,
                          builder: (context) {
                            return CustomDialogBox(
                              title: "Perhatian",
                              description: "Kontak dengan nama $nama tersimpan",
                              text: "Tutup",
                            );
                          });
                    }
                  },
                  icon: const Icon(Icons.contact_phone),
                  label: const Text("Save Contact",
                      style:
                          TextStyle(fontFamily: "SourceSansPro", fontSize: 15)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (await FlutterContacts.requestPermission()) {
                      await openWhatsapp(context, contactHP.toString());
                    }
                  },
                  icon: const Icon(Icons.whatsapp),
                  label: const Text("Whatsapp",
                      style:
                          TextStyle(fontFamily: "SourceSansPro", fontSize: 15)),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    openphoneCall(context, contactHP);
                  },
                  icon: const Icon(Icons.call),
                  label: const Text("Call",
                      style:
                          TextStyle(fontFamily: "SourceSansPro", fontSize: 15)),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                )
              ],
            ),
          ),
        ));
  }

  Positioned _positioned(context) {
    return const Positioned(
        left: 100,
        child: Image(
          width: 100,
          image: AssetImage("assets/images/icon_info.png"),
        ));
  }

  openphoneCall(context, number) async {
    var urlCall = "tel://$number";
    await launchUrl(Uri.parse(urlCall));
  }

  openWhatsapp(context, number) async {
    var whatsappUrl = "https://wa.me/$number";

    if (Platform.isIOS) {
      if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
        await launchUrl(Uri.parse(whatsappUrl),
            mode: LaunchMode.platformDefault);
      } else {
        return showDialog(
            context: context,
            builder: ((context) {
              return const CustomDialogBox(
                title: "Perhatian",
                description: "Whatsapp not installed",
                text: "Tutup",
              );
            }));
      }
    } else {
      if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
        await launchUrl(Uri.parse(whatsappUrl),
            mode: LaunchMode.externalApplication);
      } else {
        showDialog(
            context: context,
            builder: ((context) {
              return const CustomDialogBox(
                title: "Perhatian",
                description: "Whatsapp not installed",
                text: "Tutup",
              );
            }));
      }
    }
  }
}
