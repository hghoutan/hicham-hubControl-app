
import 'package:flutter/material.dart';

class ScaleController extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..strokeWidth = size.width / 4.4
      ..color = Colors.grey.shade300
      ..strokeCap = StrokeCap.round;

    final p1 = Offset(0, size.height * 1/2);
    final p2 = Offset(size.width, size.height * 1/2);
    canvas.drawLine(p1, p2, linePaint);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
