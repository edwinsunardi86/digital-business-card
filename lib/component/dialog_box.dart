import 'package:flutter/material.dart';

class Constants {
  Constants._();

  static const double padding = 20;
  static const double avatarRadius = 45;
}

class DialogBox extends StatelessWidget {
  final String? title, description;
  final Widget? action;
  final Image? img;
  const DialogBox(
      {Key? key, this.title, this.description, this.img, this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[_container(context), _positioned(context)],
    );
  }

  Positioned _positioned(context) => Positioned(
        left: Constants.padding,
        right: Constants.padding,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: Constants.avatarRadius,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Constants.avatarRadius),
            child:
                const Image(image: AssetImage("assets/images/icon_info.png")),
          ),
        ),
      );

  Container _container(context) => Container(
        padding: const EdgeInsets.only(
            left: Constants.padding,
            top: Constants.avatarRadius + Constants.padding,
            right: Constants.padding,
            bottom: Constants.padding),
        margin: const EdgeInsets.only(top: Constants.avatarRadius),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(Constants.padding),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black, blurRadius: 10, offset: Offset(0, 10))
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title.toString(),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),
            Text(
              description.toString(),
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Align(alignment: Alignment.bottomCenter, child: action)
          ],
        ),
      );
}
