import 'package:flutter/material.dart';

class HomeButton extends StatefulWidget {
  const HomeButton({super.key});

  @override
  State<HomeButton> createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: HomeButtonPainter(),
    );
  }
}
class HomeButtonPainter  extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {
    var circlePaint = Paint()
    ..color = Colors.grey.shade100;

    var center = Offset(size.width * 1/2, size.height * 1/2);
    canvas.drawCircle(center, size.width * .5, circlePaint);

    Paint firstHalfPaint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke
    ;
    Paint secondHalfPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke
    ;

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      3.14 / 2,
      3.14,
      false,
      firstHalfPaint,
    );
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      (3 * 3.14) / 2,
      3.14  ,
      false,
      secondHalfPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {

    return false;
  }
}
