import 'dart:io';

import 'package:digital_business/API/api_delete_data_contact.dart';
import 'package:digital_business/component/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:digital_business/API/api_list_data_contact.dart';
import 'package:digital_business/component/contact_action_box.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:digital_business/component/custom_dialog_box.dart';
import 'package:url_launcher/url_launcher.dart';

class DataContact extends StatefulWidget {
  const DataContact({Key? key}) : super(key: key);

  @override
  State<DataContact> createState() => _DataContactState();
}

class _DataContactState extends State<DataContact> {
  // late List<Map<String, String>> futureData = dataContact;
  TextEditingController filterData = TextEditingController();
  late List<APIListDataContact> dataContact;
  void filterSearch(String query) {
    Future<List<APIListDataContact>> getData =
        APIListDataContact.fetchDataContact();
    getData.then((value) => value.map((e) => null));
  }

  @override
  Widget build(BuildContext context) {
    Color? eventColorTextField;
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
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          // height: 40,
          child: Focus(
            onFocusChange: ((hasFocus) {
              if (hasFocus == true) {
                eventColorTextField = Colors.blue;
              } else {
                eventColorTextField = Colors.grey;
              }
            }),
            child: TextField(
              controller: filterData,
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.filter, color: eventColorTextField),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0.5, color: Colors.blue),
                      borderRadius: BorderRadius.circular(5)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0.5, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5))),
            ),
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
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
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
                                    // Ink(
                                    //   width: 50,
                                    //   height: 50,
                                    //   decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.circular(30),
                                    //       image: const DecorationImage(
                                    //           image: NetworkImage(
                                    //               "https://images.unsplash.com/photo-1589405858862-2ac9cbb41321?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"),
                                    //           fit: BoxFit.fill)),
                                    //   child: InkWell(
                                    //     onTap: () {
                                    //       Navigator.pushReplacement(context,
                                    //           MaterialPageRoute(
                                    //               builder: (context) {
                                    //         return ContactActionBox(
                                    //             id: snapshot.data![index].id,
                                    //             nama: snapshot.data![index].nama,
                                    //             company:
                                    //                 snapshot.data![index].company,
                                    //             contactHP: snapshot
                                    //                 .data![index].contactHp);
                                    //       }));
                                    //     },
                                    //   ),
                                    // ),
                                    const SizedBox(width: 10),
                                    Ink(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          splashColor: Colors.white,
                                          highlightColor: const Color.fromARGB(
                                              255, 90, 6, 0),
                                          onTap: () {
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
                                                                        builder: ((context) =>
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
                                                                icon:
                                                                    const Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                label:
                                                                    const Text(
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
                                                                            Colors.red)),
                                                            ElevatedButton.icon(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                icon: const Icon(
                                                                    Icons
                                                                        .cancel,
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
                                          child: const Icon(Icons.delete,
                                              color: Colors.white)),
                                    ),
                                    // ElevatedButton(
                                    //     onPressed: () {
                                    //       showDialog(
                                    //           context: context,
                                    //           builder: (context) {
                                    //             return DialogBox(
                                    //                 title:
                                    //                     "Hapus Data ${snapshot.data![index].nama}",
                                    //                 description:
                                    //                     "Apakah anda ingin menghapus data contact ${snapshot.data![index].nama}?",
                                    //                 action: Row(
                                    //                     mainAxisAlignment:
                                    //                         MainAxisAlignment
                                    //                             .spaceAround,
                                    //                     children: [
                                    //                       ElevatedButton.icon(
                                    //                           onPressed: () {
                                    //                             APIDeleteContact.deleteDataContact(snapshot
                                    //                                     .data![
                                    //                                         index]
                                    //                                     .id
                                    //                                     .toString())
                                    //                                 .then(
                                    //                                     (value) {
                                    //                               //print(value['contact_nama']);
                                    //                               showDialog(
                                    //                                   context:
                                    //                                       context,
                                    //                                   builder:
                                    //                                       ((context) =>
                                    //                                           DialogBox(
                                    //                                             title: "Perhatian!",
                                    //                                             description:
                                    //                                                 // ignore: prefer_interpolation_to_compose_strings
                                    //                                                 "${"Data kontak dengan nama " + value['contact_nama']} berhasil dihapus",
                                    //                                             action: ElevatedButton.icon(
                                    //                                                 onPressed: () {
                                    //                                                   // Navigator.of(
                                    //                                                   //         context)
                                    //                                                   //     .pop();
                                    //                                                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                    //                                                     return const DataContact();
                                    //                                                   }));
                                    //                                                 },
                                    //                                                 icon: const Icon(Icons.close),
                                    //                                                 label: const Text("Tutup", style: TextStyle(color: Colors.white, fontFamily: "SourceSansPro"))),
                                    //                                           )));
                                    //                             });
                                    //                           },
                                    //                           icon: const Icon(
                                    //                             Icons.delete,
                                    //                             color:
                                    //                                 Colors.white,
                                    //                           ),
                                    //                           label: const Text(
                                    //                             "Hapus",
                                    //                             style: TextStyle(
                                    //                                 color: Colors
                                    //                                     .white,
                                    //                                 fontFamily:
                                    //                                     "SourceSansPro"),
                                    //                           ),
                                    //                           style: ElevatedButton
                                    //                               .styleFrom(
                                    //                                   backgroundColor:
                                    //                                       Colors
                                    //                                           .red)),
                                    //                       ElevatedButton.icon(
                                    //                           onPressed: () {
                                    //                             Navigator.of(
                                    //                                     context)
                                    //                                 .pop();
                                    //                           },
                                    //                           icon: const Icon(
                                    //                               Icons.cancel,
                                    //                               color: Colors
                                    //                                   .white),
                                    //                           label: const Text(
                                    //                               "Batal",
                                    //                               style: TextStyle(
                                    //                                   color: Colors
                                    //                                       .white,
                                    //                                   fontFamily:
                                    //                                       "SourceSansPro")))
                                    //                     ]));
                                    //           });
                                    //     },
                                    //     style: ElevatedButton.styleFrom(
                                    //         padding: const EdgeInsets.all(5),
                                    //         backgroundColor: Colors.red),
                                    //     child: const Icon(Icons.delete)),
                                    const SizedBox(width: 10),
                                    Ink(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(5),
                                        highlightColor: const Color.fromARGB(
                                            255, 10, 45, 73),
                                        onTap: () async {
                                          if (await FlutterContacts
                                              .requestPermission()) {
                                            final Contact newContact =
                                                Contact();
                                            newContact.name = Name(
                                                nickname: snapshot
                                                    .data![index].nama
                                                    .toString());
                                            newContact.organizations = [
                                              Organization(
                                                  company: snapshot
                                                      .data![index].company
                                                      .toString()
                                                      .toString())
                                            ];
                                            newContact.phones = [
                                              Phone(snapshot
                                                  .data![index].contactHp
                                                  .toString()
                                                  .toString())
                                            ];
                                            await newContact.insert();
                                            APIDeleteContact.deleteDataContact(
                                                snapshot.data![index].id
                                                    .toString());
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
                                        child: const Icon(Icons.contact_page,
                                            color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Ink(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(5),
                                        highlightColor:
                                            const Color.fromARGB(255, 0, 61, 2),
                                        onTap: () async {
                                          if (await FlutterContacts
                                              .requestPermission()) {
                                            await openWhatsapp(
                                                context,
                                                snapshot.data![index].contactHp
                                                    .toString());
                                          }
                                        },
                                        child: const Icon(
                                          Icons.whatsapp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Ink(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.yellow),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(5),
                                        highlightColor: const Color.fromARGB(
                                            255, 71, 64, 0),
                                        onTap: () {
                                          openphoneCall(context,
                                              snapshot.data![index].contactHp);
                                        },
                                        child: const Icon(Icons.call,
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
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
            mode: LaunchMode.externalNonBrowserApplication);
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
