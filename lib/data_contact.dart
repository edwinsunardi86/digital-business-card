import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

List<Map<String, String>> dataContact = <Map<String, String>>[
  {
    'nama': 'Edwin Budiyanto Ganteng',
    'company': 'PT. SOS Indonesia',
    'contact': '081317857424'
  },
  {
    'nama': 'Hadi Sudiro',
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
  late List<Map<String, String>> futureData = dataContact;

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
        Expanded(
          // child: ListView.builder(
          //     scrollDirection: Axis.vertical,
          //     itemCount: dataContact.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       return ListTile(
          //           title: Text(dataContact.map((e) => e).toString()));
          //     }),
          child: futureData.isNotEmpty
              ? ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: futureData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(
                          dataContact[index].values.elementAt(0),
                          style: const TextStyle(
                              fontFamily: "SourceSansPro",
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          dataContact[index].values.elementAt(1),
                          style: const TextStyle(
                              fontFamily: "SourceSansPro", fontSize: 15),
                        ),
                        trailing: Column(
                          children: [
                            Text(
                              dataContact[index].values.elementAt(2),
                              style: const TextStyle(
                                  fontFamily: "SourceSansPro", fontSize: 15),
                            ),
                            GestureDetector(
                                onTap: () async {
                                  final PermissionStatus permissionStatus =
                                      await _getPermission();
                                  if (await FlutterContacts
                                      .requestPermission()) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Bisa"),
                                          );
                                        });
                                    final newContact = Contact();
                                    //List<Organization> company = [dataContact[index].values.elementAt(1)];
                                    newContact.displayName = dataContact[index]
                                        .values
                                        .elementAt(0)
                                        .toString();
                                    newContact.organizations = [
                                      Organization(
                                          company: dataContact[index]
                                              .values
                                              .elementAt(1))
                                    ];
                                    newContact.phones = [
                                      Phone(dataContact[index]
                                          .values
                                          .elementAt(2)
                                          .toString())
                                    ];
                                    await newContact.insert();
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Tidak Bisa"),
                                          );
                                        });
                                  }
                                },
                                child: Icon(Icons.import_contacts))
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Text(""),
        )
      ],
    ));
  }

  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ?? PermissionStatus.denied;
    } else {
      return permission;
    }
  }
}
