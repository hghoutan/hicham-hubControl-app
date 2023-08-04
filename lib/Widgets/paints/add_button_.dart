import 'package:flutter/material.dart';

class AddButton extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final addRemoveDegreePaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = size.width / 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final addDegreePath = Path();

    //region AddDegreePath
    addDegreePath.moveTo(size.width * 1/2 , 15);
    addDegreePath.lineTo(size.width * 2/6, 30);
    addDegreePath.moveTo(size.width * 1/2 , 15);
    addDegreePath.lineTo(size.width * 4/6,30);
    //endregion


    canvas.drawPath(addDegreePath, addRemoveDegreePaint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
      return false;
  }

}