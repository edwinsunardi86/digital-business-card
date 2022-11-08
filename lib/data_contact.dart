import 'dart:io';

import 'package:digital_business/API/api_delete_data_contact.dart';
import 'package:digital_business/API/api_update_data_contact.dart';
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
  late List<APIListDataContact> myData = [];
  late List<APIListDataContact> unFilteredData = [];
  late String textData = "";
  TextEditingController filterTextData = TextEditingController();
  Future<List<APIListDataContact>> loadDataContact() async {
    List<APIListDataContact> data = await APIListDataContact.fetchDataContact();
    setState(() {
      myData = data;
      unFilteredData = myData;
    });
    print(myData.length);
    return data;
  }

  @override
  void initState() {
    super.initState();
    loadDataContact();
  }

  @override
  Widget build(BuildContext context) {
    // print(APIListDataContact.fetchDataContact()
    //     .then((value) => value.map((e) => e.nama).toString()));
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
              onChanged: (String filterTextData) {
                setState(() {
                  textData = filterTextData.toString();
                });
              },
              controller: filterTextData,
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
            // future: APIListDataContact.fetchDataContact(),
            future: APIListDataContact.fetchDataContact(),
            builder:
                (context, AsyncSnapshot<List<APIListDataContact>> snapshot) {
              if (snapshot.hasData) {
                //List<APIListDataContact>? dataContact = myData;
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                        String id = snapshot.data![index].id.toString();
                        String nama = snapshot.data![index].nama.toString();
                        String company =
                            snapshot.data![index].company.toString();
                        String kodeDial =
                            snapshot.data![index].kodeDial.toString();
                        String contactHp =
                            snapshot.data![index].contactHp.toString();

                        if (nama
                            .contains(RegExp(textData, caseSensitive: false))) {
                          return cardContact(
                              company, nama, kodeDial, contactHp, context, id);
                        } else if (filterTextData.text == "") {
                          return cardContact(
                              company, nama, kodeDial, contactHp, context, id);
                        } else {
                          return Card();
                        }
                      }),
                );
              } else {
                return Text("");
              }
            }),
      ],
    ));
  }

  Widget cardContact(String company, String nama, String kodeDial,
      String contactHp, BuildContext context, String id) {
    return Card(
      elevation: 5,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            ListTile(
              title: Text(
                company,
                style: const TextStyle(
                    fontFamily: "SourceSansPro",
                    fontStyle: FontStyle.italic,
                    fontSize: 15),
              ),
              leading: Text(
                nama,
                style: const TextStyle(
                    fontFamily: "SourceSansPro",
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              trailing: Text(
                kodeDial + contactHp,
                style: const TextStyle(
                    fontFamily: "SourceSansPro",
                    // fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 10),
                Ink(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5)),
                  child: InkWell(
                      borderRadius: BorderRadius.circular(5),
                      splashColor: Colors.white,
                      highlightColor: const Color.fromARGB(255, 90, 6, 0),
                      onTap: () {
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
                                              APIDeleteContact
                                                      .deleteDataContact(id)
                                                  .then((value) {
                                                //print(value['contact_nama']);
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        ((context) => DialogBox(
                                                              title:
                                                                  "Perhatian!",
                                                              description:
                                                                  // ignore: prefer_interpolation_to_compose_strings
                                                                  "Data kontak dengan nama $nama berhasil dihapus",
                                                              action: ElevatedButton
                                                                  .icon(
                                                                      onPressed:
                                                                          () {
                                                                        // Navigator.of(
                                                                        //         context)
                                                                        //     .pop();
                                                                        Navigator.pushReplacement(
                                                                            context,
                                                                            MaterialPageRoute(builder:
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
                                                                              color: Colors.white,
                                                                              fontFamily: "SourceSansPro"))),
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
                                                    fontFamily:
                                                        "SourceSansPro")))
                                      ]));
                            });
                      },
                      child: const Icon(Icons.delete, color: Colors.white)),
                ),
                const SizedBox(width: 10),
                Ink(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    highlightColor: const Color.fromARGB(255, 10, 45, 73),
                    onTap: () {
                      BuildContext dialogContext;
                      showDialog(
                          context: context,
                          builder: (context) {
                            dialogContext = context;
                            return DialogBox(
                                title: "Perhatian",
                                description:
                                    "Apakah anda ingin menyimpan data kontak ini ke phone book anda?",
                                action: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () async {
                                        if (await FlutterContacts
                                            .requestPermission()) {
                                          final Contact newContact = Contact();
                                          newContact.name =
                                              Name(nickname: nama);
                                          newContact.organizations = [
                                            Organization(company: company)
                                          ];
                                          newContact.phones = [
                                            Phone(contactHp)
                                          ];
                                          await newContact.insert();
                                          await APIUpdateContact
                                              .updateHiddenContact(id);
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return CustomDialogBox(
                                                  title: "Perhatian",
                                                  description:
                                                      "Kontak dengan nama $nama tersimpan",
                                                  text: "Tutup",
                                                );
                                              });
                                        }
                                        if (mounted) {
                                          Navigator.pushReplacement(
                                              dialogContext, MaterialPageRoute(
                                                  builder: (dialogContext) {
                                            return const DataContact();
                                          }));
                                        } else {
                                          return;
                                        }
                                      },
                                      icon: const Icon(Icons.save),
                                      label: const Text("Save"),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green),
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: const Icon(
                                        Icons.cancel,
                                        color: Colors.black,
                                      ),
                                      label: const Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white),
                                    )
                                  ],
                                ));
                          });
                    },
                    child: const Icon(Icons.contact_page, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                Ink(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    highlightColor: const Color.fromARGB(255, 0, 61, 2),
                    onTap: () async {
                      if (await FlutterContacts.requestPermission()) {
                        await openWhatsapp(
                            context, kodeDial + contactHp.toString());
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
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.yellow),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    highlightColor: const Color.fromARGB(255, 71, 64, 0),
                    onTap: () {
                      openphoneCall(context, kodeDial + contactHp);
                    },
                    child: const Icon(Icons.call, color: Colors.white),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  openphoneCall(context, String number) async {
    var urlCall = "tel://+$number";
    await launchUrl(Uri.parse(urlCall));
  }

  openWhatsapp(context, String number) async {
    var whatsappUrl = "https://api.whatsapp.com/send?phone=" + number;

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
            mode: LaunchMode.platformDefault);
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

    Widget(
      snapshot,
      index,
    ) {}
  }

  // void searchdata() {
  //   var strExist = filterTextData.text.isNotEmpty ? true : false;
  //   String? nama;
  //   String? company;
  //   String? contactHp;
  //   if (strExist) {
  //     List<APIListDataContact>? filterData;
  //     for (var i = 0; i < unFilteredData.length; i++) {
  //       unFilteredData.map((e) {
  //         setState(() {
  //           nama = e.nama.toString();
  //           company = e.company.toString();
  //           contactHp = e.contactHp.toString();
  //         });
  //       });
  //       if (nama!.contains(filterTextData.text) ||
  //           company!.contains(filterTextData.text) ||
  //           contactHp!.contains(filterTextData.text)) {
  //         filterData!.add(unFilteredData[i]);
  //         setState(() {
  //           myData = filterData;
  //         });
  //       } else {
  //         setState(() {
  //           myData = unFilteredData;
  //         });
  //       }
  //     }
  //   } else {
  //     setState(() {
  //       myData = unFilteredData;
  //     });
  //   }
  // }
}
