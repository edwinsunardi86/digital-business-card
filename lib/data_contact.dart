import 'dart:io';

import 'package:digital_business/API/api_delete_data_contact.dart';
import 'package:digital_business/component/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:digital_business/API/api_list_data_contact.dart';
// import 'package:digital_business/component/contact_action_box.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:digital_business/component/custom_dialog_box.dart';
import 'package:url_launcher/url_launcher.dart';

List<Map<String, String>> dataContact = <Map<String, String>>[
  {
    'nama': 'Edwin Budiyanto Ganteng',
    'email': 'edwinsunardi@gmail.com',
    'company': 'PT. SOS Indonesia',
    'contact': '081317857424'
  },
  {
    'nama': 'Hadi Sudiro',
    'email': 'hadisudiro@gmail.com',
    'company': 'PT. Sentul City',
    'contact': '22222222222'
  }
];

class DataContact extends StatefulWidget {
  const DataContact({Key? key}) : super(key: key);

  @override
  State<DataContact> createState() => _DataContactState();
}

class _DataContactState extends State<DataContact> {
  // late List<Map<String, String>> futureData = dataContact;
  late List<APIListDataContact> dataContact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
            margin: const EdgeInsets.all(30),
            child: Center(
              child: Image(
                width: MediaQuery.of(context).size.width * 0.30,
                image: const AssetImage("assets/images/Logos.png"),
              ),
            )),
        Container(
          margin: const EdgeInsets.only(top: 15, bottom: 30),
          child: const Text(
            "Data Contact",
            style: TextStyle(
                fontFamily: "SourceSansPro",
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
        ),
        FutureBuilder(
            future: APIListDataContact.fetchDataContact(),
            builder:
                (context, AsyncSnapshot<List<APIListDataContact>> snapshot) {
              if (snapshot.hasData) {
                List<APIListDataContact>? dataContact = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                      itemCount: dataContact!.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  snapshot.data![index].company.toString(),
                                  style: const TextStyle(
                                      fontFamily: "SourceSansPro",
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15),
                                ),
                                leading: Text(
                                  snapshot.data![index].nama.toString(),
                                  style: const TextStyle(
                                      fontFamily: "SourceSansPro",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                trailing: Text(
                                  snapshot.data![index].contactHp.toString(),
                                  style: const TextStyle(
                                      fontFamily: "SourceSansPro",
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              Row(
                                children: [
                                  ElevatedButton.icon(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return DialogBox(
                                                  title:
                                                      "Hapus Data ${snapshot.data![index].nama}",
                                                  description:
                                                      "Apakah anda ingin menghapus data contact ${snapshot.data![index].nama}?",
                                                  action: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        ElevatedButton.icon(
                                                            onPressed: () {
                                                              APIDeleteContact.deleteDataContact(snapshot
                                                                      .data![
                                                                          index]
                                                                      .id
                                                                      .toString())
                                                                  .then(
                                                                      (value) {
                                                                //print(value['contact_nama']);
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        ((context) =>
                                                                            DialogBox(
                                                                              title: "Perhatian!",
                                                                              description:
                                                                                  // ignore: prefer_interpolation_to_compose_strings
                                                                                  "${"Data kontak dengan nama " + value['contact_nama']} berhasil dihapus",
                                                                              action: ElevatedButton.icon(
                                                                                  onPressed: () {
                                                                                    // Navigator.of(
                                                                                    //         context)
                                                                                    //     .pop();
                                                                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                                                                      return const DataContact();
                                                                                    }));
                                                                                  },
                                                                                  icon: const Icon(Icons.close),
                                                                                  label: const Text("Tutup", style: TextStyle(color: Colors.white, fontFamily: "SourceSansPro"))),
                                                                            )));
                                                              });
                                                            },
                                                            icon: const Icon(
                                                              Icons.delete,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            label: const Text(
                                                              "Hapus",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      "SourceSansPro"),
                                                            ),
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red)),
                                                        ElevatedButton.icon(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            icon: const Icon(
                                                                Icons.cancel,
                                                                color: Colors
                                                                    .white),
                                                            label: const Text(
                                                                "Batal",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        "SourceSansPro")))
                                                      ]));
                                            });
                                      },
                                      icon: const Icon(Icons.delete),
                                      label: const Text("Delete",
                                          style: TextStyle(
                                              fontFamily: "SourceSansPro",
                                              fontSize: 12)),
                                      style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(5),
                                          backgroundColor: Colors.red)),
                                  const SizedBox(width: 10),
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      if (await FlutterContacts
                                          .requestPermission()) {
                                        final Contact newContact = Contact();
                                        newContact.name = Name(
                                            nickname: snapshot.data![index].nama
                                                .toString());
                                        newContact.organizations = [
                                          Organization(
                                              company: snapshot
                                                  .data![index].company
                                                  .toString()
                                                  .toString())
                                        ];
                                        newContact.phones = [
                                          Phone(snapshot.data![index].contactHp
                                              .toString()
                                              .toString())
                                        ];
                                        await newContact.insert();

                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return CustomDialogBox(
                                                title: "Perhatian",
                                                description:
                                                    "Kontak dengan nama ${snapshot.data![index].nama.toString()} tersimpan",
                                                text: "Tutup",
                                              );
                                            });
                                      }
                                    },
                                    icon: const Icon(Icons.contact_phone),
                                    label: const Text("Save",
                                        style: TextStyle(
                                            fontFamily: "SourceSansPro",
                                            fontSize: 12)),
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(5),
                                        backgroundColor: Colors.blue),
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      if (await FlutterContacts
                                          .requestPermission()) {
                                        await openWhatsapp(
                                            context,
                                            snapshot.data![index].contactHp
                                                .toString());
                                      }
                                    },
                                    icon: const Icon(Icons.whatsapp),
                                    label: const Text("Whatsapp",
                                        style: TextStyle(
                                            fontFamily: "SourceSansPro",
                                            fontSize: 15)),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green),
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      openphoneCall(context,
                                          snapshot.data![index].contactHp);
                                    },
                                    icon: const Icon(Icons.call),
                                    label: const Text("Call",
                                        style: TextStyle(
                                            fontFamily: "SourceSansPro",
                                            fontSize: 15)),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                );
              } else {
                return Text("");
              }
            }),
      ],
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
