import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:digital_business/API/api_list_data_contact.dart';
import 'package:digital_business/component/contact_action_box.dart';

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
  late List<APIDataContact> dataContact;

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
            future: APIDataContact.fetchDataContact(),
            builder: (context, AsyncSnapshot<List<APIDataContact>> snapshot) {
              if (snapshot.hasData) {
                List<APIDataContact>? dataContact = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                      itemCount: dataContact!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          child: ListTile(
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
                            subtitle: Text(
                              snapshot.data![index].contactHp.toString(),
                              style: const TextStyle(
                                  fontFamily: "SourceSansPro",
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            trailing: Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton.icon(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: ((context) {
                                              return ContactActionBox(
                                                  nama: snapshot
                                                      .data![index].nama,
                                                  company: snapshot
                                                      .data![index].company,
                                                  contactHP: snapshot
                                                      .data![index].contactHp);
                                            }));
                                      },
                                      icon: const Icon(Icons.smart_button),
                                      label: const Text("Action")),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
              } else {
                return Text("");
              }
            }),
        // Expanded(
        //   child: futureData.isNotEmpty
        //       ? ListView.separated(
        //           separatorBuilder: (BuildContext context, int index) =>
        //               const Divider(),
        //           itemCount: futureData.length,
        //           itemBuilder: (context, index) {
        //             return Card(
        //               elevation: 5,
        //               child: ListTile(
        //                 title: Text(
        //                   dataContact[index].values.elementAt(0),
        //                   style: const TextStyle(
        //                       fontFamily: "SourceSansPro",
        //                       fontSize: 20,
        //                       fontWeight: FontWeight.bold),
        //                 ),
        //                 subtitle: Text(
        //                   dataContact[index].values.elementAt(1),
        //                   style: const TextStyle(
        //                       fontFamily: "SourceSansPro", fontSize: 15),
        //                 ),
        //                 trailing: Column(
        //                   children: [
        //                     Text(
        //                       dataContact[index].values.elementAt(2),
        //                       style: const TextStyle(
        //                           fontFamily: "SourceSansPro", fontSize: 15),
        //                     ),
        //                     GestureDetector(
        //                         onTap: () async {
        //                           final PermissionStatus permissionStatus =
        //                               await _getPermission();
        //                           if (await FlutterContacts
        //                               .requestPermission()) {
        //                             showDialog(
        //                                 context: context,
        //                                 builder: (context) {
        //                                   return AlertDialog(
        //                                     title: Text("Bisa"),
        //                                   );
        //                                 });
        //                             final newContact = Contact();
        //                             //List<Organization> company = [dataContact[index].values.elementAt(1)];
        //                             newContact.name = Name(
        //                                 nickname: dataContact[index]
        //                                     .values
        //                                     .elementAt(0));
        //                             newContact.emails = [
        //                               Email(dataContact[index]
        //                                   .values
        //                                   .elementAt(1))
        //                             ];
        //                             newContact.organizations = [
        //                               Organization(
        //                                   company: dataContact[index]
        //                                       .values
        //                                       .elementAt(2))
        //                             ];
        //                             newContact.phones = [
        //                               Phone(dataContact[index]
        //                                   .values
        //                                   .elementAt(3)
        //                                   .toString())
        //                             ];

        //                             await newContact.insert();
        //                           } else {
        //                             showDialog(
        //                                 context: context,
        //                                 builder: (context) {
        //                                   return AlertDialog(
        //                                     title: Text("Tidak Bisa"),
        //                                   );
        //                                 });
        //                           }
        //                         },
        //                         child: Icon(Icons.import_contacts))
        //                   ],
        //                 ),
        //               ),
        //             );
        //           },
        //         )
        //       : Text(""),
        // )
      ],
    ));
  }
}
