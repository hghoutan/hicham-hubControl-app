import 'package:flutter/material.dart';

class RemoveButton extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final addRemoveDegreePaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = size.width / 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;


    final removeDegreePath =Path();


    // region RemoveDegreePath
    removeDegreePath.moveTo(size.width * 1/2 , size.height -10  );
    removeDegreePath.lineTo(size.width * 2/6,  size.height - 25);
    removeDegreePath.moveTo(size.width * 1/2 , size.height - 10 );
    removeDegreePath.lineTo(size.width * 4/6, size.height - 25 );
    //endregion

    canvas.drawPath(removeDegreePath, addRemoveDegreePaint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}