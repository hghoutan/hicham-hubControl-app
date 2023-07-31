import 'package:flutter/material.dart';

import '../utils/dimension.dart';

class HomeButton extends StatefulWidget {
  const HomeButton({super.key});

  @override
  State<HomeButton> createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {
  @override
  Widget build(BuildContext context) {
    return  Stack(
        children: [
          Container(
            width: Dimension.getScreenHeight() * 13/100,
            height: Dimension.getScreenHeight() * 13/100,
            child: CustomPaint(
                  foregroundPainter: HomeButtonPainter()),
          ),
          SizedBox(
            width: Dimension.getScreenHeight() * 13/100,
            height: Dimension.getScreenHeight() * 13/100,
            child: Center(
              child: Container(
                 width: Dimension.getScreenHeight() * 10.5/100,
            height: Dimension.getScreenHeight() * 10.5/100,
                  child:  Column(
                    children: [
                      SizedBox(
                        height: Dimension.getScreenHeight() * 1/100,
                      ),
                       Text(
                        "Off",
                        style: TextStyle(
                          fontSize: Dimension.getScreenWidth() * 5/100,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Colors.black87,
                        ),
                      ),
                    
                       Text(
                        "Turn on in",
                        style: TextStyle(
                          fontSize: Dimension.getScreenWidth() * 3/100,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                       Text(
                        "Mode",
                        style: TextStyle(
                          fontSize: Dimension.getScreenWidth() * 3/100,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  )
              ),
            ),
          ),
        ]
    );
    //   CustomPaint(
    //   foregroundPainter: HomeButtonPainter(),
    // );
  }
}
class HomeButtonPainter  extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {

    var circlePaint = Paint()
    ..color = Colors.grey.shade100;

    var center = Offset(size.width * 1/2, size.height * 1/2);

    //region draw shadow
    var path = Path();
    path.addOval(Rect.fromCircle(center: center, radius: size.width * 1/2 + 10));
    canvas.drawShadow(path, Color(0xff000000), 3, true);
    //endregion

    canvas.drawCircle(center, size.width * .5, circlePaint);

    Paint firstHalfPaint = Paint()
      ..color = Colors.black87
      ..strokeWidth = size.width / 7
      ..style = PaintingStyle.stroke
    ;
    Paint secondHalfPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = size.width / 7
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
