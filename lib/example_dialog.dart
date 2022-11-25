import 'component/dialog_box.dart';
import 'package:flutter/material.dart';

class MyDialogAlert extends StatelessWidget {
  const MyDialogAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 100,
        height: 50,
        margin: EdgeInsets.all(50),
        child: ElevatedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Align(
                    alignment: Alignment.center,
                    child: DialogBox(
                        title: "TEST", description: "TEST 123 berhasil"),
                  );
                });
          },
          child: Text("Test"),
        ),
      ),
    );
  }
}
