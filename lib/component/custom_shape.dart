import 'package:flutter/material.dart';

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.25);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 0.75, size.width, size.height * 0.25);
    path.lineTo(size.width, size.height);

    // path.quadraticBezierTo(
    //     size.width * 0.5, size.height * 0.25, size.width, size.height * 0.75);
    //path.lineTo(size.width, size.height);
    // path.quadraticBezierTo(
    //     size.width * 0.25, size.height * 0.15, size.width * 0.5, 0);
    //path.lineTo(size.width, size.height);
    // path.quadraticBezierTo(
    //     size.width * 0.25, size.height * 0.35, size.width * 0.5, size.height);
    // path.lineTo(size.width, size.height);
    // path.lineTo(size.width, 0);
    //path.quadraticBezierTo(size.width, y1, x2, y2)
    // path.quadraticBezierTo(size.width * 0.25, size.height * 0.95,
    // size.width * 0.5, size.height * 0.75);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
