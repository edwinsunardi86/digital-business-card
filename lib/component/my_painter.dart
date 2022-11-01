import 'package:flutter/material.dart';

const double _kRadius = 5;
const double _kBorderWidth = 2.5;

class MyPainter extends CustomPainter {
  MyPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rrectBorder = RRect.fromRectAndRadius(
        Offset.zero & size, const Radius.circular(_kRadius));
    final rrectShadow = RRect.fromRectAndRadius(
        const Offset(0, 3) & size, const Radius.circular(_kRadius));

    final shadowPaint = Paint()
      ..strokeWidth = _kBorderWidth
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
    final borderPaint = Paint()
      ..strokeWidth = _kBorderWidth
      ..color = Colors.white
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(rrectShadow, shadowPaint);
    canvas.drawRRect(rrectBorder, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
