import 'package:flutter/material.dart';

class ConstantsValue {
  ConstantsValue._();
  static const double paddingVal = 20;
  static const double iconValue = 45;
}

class contactActionBox extends StatelessWidget {
  final String? nama;
  final String? company;
  final String? contactHP;
  const contactActionBox({super.key, this.nama, this.company, this.contactHP});

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
    return Stack(children: [_container(context)]);
  }

  Container _container(context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(
            ConstantsValue.paddingVal,
            ConstantsValue.paddingVal + ConstantsValue.iconValue,
            ConstantsValue.paddingVal,
            ConstantsValue.paddingVal),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Color.fromARGB(255, 65, 4, 0),
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black, offset: Offset(0, 10), blurRadius: 10)
            ]),
        child: Card(
          elevation: 5,
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nama: " + nama.toString(),
                    textAlign: TextAlign.left,
                    maxLines: 5,
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontFamily: "SourceSansPro",
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Text("Company: " + company.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontFamily: "SourceSansPro",
                      fontSize: 20,
                    )),
                const SizedBox(height: 20),
                Text(
                  "contact: " + contactHP.toString(),
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontFamily: "SourceSansPro",
                      fontSize: 20),
                ),
              ],
            ),
          ),
        ));
  }

  // Positioned _positioned(context) {
  //   return Positioned(child: );
  // }
}
