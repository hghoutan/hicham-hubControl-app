import 'package:flutter/material.dart';

import '../utils/dimension.dart';

class HomeButton extends StatelessWidget {
  final Color color;
  final String state;
  final String keyword;

  const HomeButton({super.key,required this.color,required this.state, required this.keyword});

  @override
  Widget build(BuildContext context) {
    return  Stack(
        children: [
          SizedBox(
            width: Dimension.getScreenHeight() * 15/100,
            height: Dimension.getScreenHeight() * 15/100,
            child: CustomPaint(
                foregroundPainter: HomeButtonPainter( color:color,)),
          ),
          SizedBox(
            width: Dimension.getScreenHeight() * 15/100,
            height: Dimension.getScreenHeight() * 15/100,
            child: Center(
              child: Container(
                  width: Dimension.getScreenHeight() * 11.5/100,
                  height: Dimension.getScreenHeight() * 10.5/100,
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        state,
                        style: TextStyle(
                          fontSize: Dimension.getScreenWidth() * 5/100,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Colors.black87,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          keyword,
                          style: TextStyle(
                            fontSize: Dimension.getScreenWidth() * 3.5/100,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )
              ),
            ),
          ),
        ]
    );
  }
}

class HomeButtonPainter  extends CustomPainter{
  Color color;
  HomeButtonPainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {

    var circlePaint = Paint()
    ..color = Colors.grey.shade100;

    var center = Offset(size.width * 1/2, size.height * 1/2);

    //region draw shadow
    // var path = Path();
    // path.addOval(Rect.fromCircle(center: center, radius: size.width * 1/2 + 10));
    // canvas.drawShadow(path, color, 3, true);
    //endregion

    canvas.drawCircle(center, size.width * .5, circlePaint);

    Paint firstHalfPaint = Paint()
      ..color = color
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
        height: size.height + (10/100  * size.height),
        width: size.width + (10/100  * size.height),
      ),
      3.14 / 2,
      3.14,
      false,
      firstHalfPaint,
    );
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height + (10/100  * size.height),
        width: size.width + (10/100  * size.height),
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
